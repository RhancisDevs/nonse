-- latest

workspace.ClientRenderedAssets:Destroy()
workspace:GetChildren()[17]:Destroy()

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PLACE_ID = game.PlaceId

local FILE_NAME = "player_jobs.json"
local MAX_PLAYERS = 3

local hopping = false
local LastAttemptedJobId = nil
local LastHopMethod = nil

local function sendRequest(options)
    local ok, result = pcall(function()
        return (syn and syn.request or request)(options)
    end)

    if ok and result then
        return true, result.Body
    end

    return false, nil
end

local function jsonDecodeSafe(body)
    local ok, data = pcall(HttpService.JSONDecode, HttpService, body)
    return ok and data or nil
end

local function loadJobs()
    if not isfile(FILE_NAME) then
        return {}
    end

    local ok, data = pcall(function()
        return HttpService:JSONDecode(readfile(FILE_NAME))
    end)

    if ok and type(data) == "table" then
        return data
    end

    return {}
end

local function saveJobs(data)
    pcall(function()
        writefile(FILE_NAME, HttpService:JSONEncode(data))
    end)
end

local function getJobOwner(jobs, jobId)
    for username, storedJobId in pairs(jobs) do
        if storedJobId == jobId then
            return username
        end
    end

    return nil
end

local function fetchServerPage(cursor)
    cursor = cursor or ""

    local url = string.format(
        "https://games.roblox.com/v1/games/%s/servers/Public?cursor=%s&sortOrder=Asc&excludeFullGames=true&orderBy=OccupancyAsc",
        PLACE_ID,
        cursor
    )

    local ok, body = sendRequest({
        Url = url,
        Method = "GET"
    })

    if not ok or not body then
        return nil
    end

    return jsonDecodeSafe(body)
end

local function findServer()
    local jobs = loadJobs()
    local cursor = ""

    for _ = 1, 10 do
        local data = fetchServerPage(cursor)

        if not data or not data.data then
            break
        end

        for _, server in ipairs(data.data) do
            local serverId = server.id
            local playerCount = server.playing or 0
            local maxPlayers = server.maxPlayers or 0

            if serverId
                and serverId ~= game.JobId
                and playerCount <= MAX_PLAYERS
                and playerCount < maxPlayers
                and not getJobOwner(jobs, serverId) then

                return serverId
            end
        end

        cursor = data.nextPageCursor

        if not cursor then
            break
        end
    end

    return nil
end

local function jobIdHop()
    if not hopping then
        return
    end

    local serverId = findServer()

    if not serverId then
        warn("[Hop] No suitable server found.")
        task.wait(1)
        return jobIdHop()
    end

    LastHopMethod = "jobId"
    LastAttemptedJobId = serverId

    print("[Hop] Attempting:", serverId)

    local ok = pcall(function()
        TeleportService:TeleportToPlaceInstance(
            PLACE_ID,
            serverId,
            LocalPlayer
        )
    end)

    if not ok then
        warn("[Hop] Teleport call failed.")

        LastAttemptedJobId = nil

        task.wait(0.5)

        return jobIdHop()
    end
end

TeleportService.TeleportInitFailed:Connect(function(_, result)
    if not hopping then
        return
    end

    warn("[Hop] Teleport failed:", tostring(result))

    if result == Enum.TeleportResult.GameFull then
        warn("[Hop] Game is full.")
    end

    LastAttemptedJobId = nil

    task.wait(0.5)

    jobIdHop()
end)

local function getPlayerCount()
    return #Players:GetPlayers()
end

local function checkPlayerCount()
    if hopping then
        return
    end

    local count = getPlayerCount()

    print("[JobTracker] Players:", count)

    if count > MAX_PLAYERS then
        warn(
            "[JobTracker] Server has",
            count,
            "players. Hopping..."
        )

        hopping = true
        jobIdHop()
    end
end

local function checkCurrentServer()
    local jobs = loadJobs()
    local currentJobId = game.JobId

    local owner = getJobOwner(jobs, currentJobId)

    if owner and owner ~= LocalPlayer.Name then
        warn(
            "[JobTracker] JobId conflict!",
            currentJobId,
            "belongs to",
            owner
        )

        hopping = true
        jobIdHop()

        return false
    end

    if owner == LocalPlayer.Name then
        print(
            "[JobTracker] Current server belongs to this account:",
            currentJobId
        )

        return true
    end

    jobs[LocalPlayer.Name] = currentJobId
    saveJobs(jobs)

    print(
        "[JobTracker] Claimed:",
        LocalPlayer.Name,
        "->",
        currentJobId
    )

    return true
end

Players.ChildAdded:Connect(function(child)
    if not child:IsA("Player") then
        return
    end

    task.defer(function()
        checkPlayerCount()
    end)
end)

Players.ChildRemoved:Connect(function(child)
    if not child:IsA("Player") then
        return
    end

    task.defer(function()
        checkPlayerCount()
    end)
end)

checkCurrentServer()

task.defer(function()
    task.wait(1)
    checkPlayerCount()
end)
