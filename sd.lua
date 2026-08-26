-- latest high tech

pcall(function()
    workspace.ClientRenderedAssets:Destroy()
end)

pcall(function()
    workspace.PlacedEggRenders:Destroy()
end)

pcall(function()
    workspace.PlacedEggRenders:Destroy()
end)

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EggCmds = require(
    ReplicatedStorage.Library.Client.EggCmds
)

local LocalPlayer = Players.LocalPlayer
local PLACE_ID = game.PlaceId

local API_URL = "http://us3.bot-hosting.net:21088"

local MAX_PLAYERS = 3
local PROTECTED_USERNAME = "amine100a"

local pet_target = {
    "Kitsune",
    "Unicorn",
    "Oni Tiger",
    "Eternal Lunar Dragon",
    "Mosasaurus",
    "Stag",
    "El Maja",
    "Lava Dragon",
    "Phoenix",
    "Ice Dragon",
    "Cosmic Dragon"
}

local hopping = false
local LastAttemptedJobId = nil
local LastHopMethod = nil

local eggCache = {}

local function sendRequest(options)
    local ok, result = pcall(function()
        if syn and syn.request then
            return syn.request(options)
        elseif request then
            return request(options)
        end

        error("No HTTP request function available")
    end)

    if ok and result then
        return true, result.Body, result.StatusCode
    end

    return false, nil, nil
end

local function jsonDecodeSafe(body)
    local ok, data = pcall(function()
        return HttpService:JSONDecode(body)
    end)

    if ok and type(data) == "table" then
        return data
    end

    return nil
end

local function fetchJobs()
    local ok, body = sendRequest({
        Url = API_URL .. "/list",
        Method = "GET"
    })

    if not ok or not body then
        warn("[JobTracker] Failed to fetch job list.")
        return nil
    end

    local response = jsonDecodeSafe(body)

    if not response or type(response.data) ~= "table" then
        warn("[JobTracker] Invalid API response.")
        return nil
    end

    return response.data
end

local function registerJob(username, jobId)
    local url = string.format(
        "%s/add?user=%s&jobId=%s",
        API_URL,
        HttpService:UrlEncode(username),
        HttpService:UrlEncode(jobId)
    )

    local ok, body = sendRequest({
        Url = url,
        Method = "GET"
    })

    if not ok or not body then
        warn("[JobTracker] Failed to register job.")
        return false
    end

    local response = jsonDecodeSafe(body)

    if not response or response.success ~= true then
        warn("[JobTracker] API rejected job registration.")
        return false
    end

    print(
        "[JobTracker] API:",
        response.action,
        username,
        "->",
        jobId
    )

    return true
end

local function getJobOwner(jobs, jobId)
    for _, entry in ipairs(jobs) do
        if entry.jobId == jobId then
            return entry.user
        end
    end

    return nil
end

local function fetchServerPage(cursor)
    cursor = cursor or ""

    local url = string.format(
        "https://games.roblox.com/v1/games/%s/servers/Public?cursor=%s&sortOrder=Asc&excludeFullGames=true&orderBy=OccupancyAsc",
        PLACE_ID,
        HttpService:UrlEncode(cursor)
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
    local jobs = fetchJobs()

    if not jobs then
        warn("[Hop] Could not retrieve registered servers.")
        return nil
    end

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

local function isProtectedPlayerPresent()
    return Players:FindFirstChild(PROTECTED_USERNAME) ~= nil
end

local function isTargetPet(assetCategory)
    for _, target in ipairs(pet_target) do
        if assetCategory == target then
            return true
        end
    end

    return false
end

local function LoadEggCache(snapshot)
    table.clear(eggCache)

    if not snapshot or type(snapshot.Records) ~= "table" then
        return
    end

    for _, egg in ipairs(snapshot.Records) do
        if egg.Uid then
            eggCache[egg.Uid] = egg.AssetCategory
        end
    end
end

local function hasTargetPetFromCache()
    for _, assetCategory in pairs(eggCache) do
        if isTargetPet(assetCategory) then
            return true
        end
    end

    return false
end

local function refreshTargetPetState()
    local snapshot = EggCmds.GetAreaEggSnapshot()

    if not snapshot or type(snapshot.Records) ~= "table" then
        return false
    end

    LoadEggCache(snapshot)

    for _, egg in ipairs(snapshot.Records) do
        if isTargetPet(egg.AssetCategory) then
            print(
                "[PetTracker] Target found:",
                egg.AssetCategory,
                "| UID:",
                tostring(egg.Uid)
            )

            return true
        end
    end

    return false
end

local function getPlayerCount()
    return #Players:GetPlayers()
end

local function checkPlayerCount()
    if hopping then
        return false
    end

    local count = getPlayerCount()

    print("[JobTracker] Players:", count)

    if isProtectedPlayerPresent() then
        print(
            "[JobTracker] Protected player present:",
            PROTECTED_USERNAME
        )

        return true
    end

    if hasTargetPetFromCache() then
        print("[PetTracker] Target pet is present.")
        return true
    end

    if count > MAX_PLAYERS then
        warn(
            "[JobTracker] Too many players:",
            count,
            "-> server hopping"
        )

        hopping = true
        jobIdHop()

        return false
    end

    return true
end

local function checkCurrentServer()
    if hopping then
        return false
    end

    local jobs = fetchJobs()

    if not jobs then
        warn("[JobTracker] Cannot check current server.")
        return false
    end

    local currentJobId = game.JobId

    local owner = getJobOwner(
        jobs,
        currentJobId
    )

    if owner and owner ~= LocalPlayer.Name then
        warn(
            "[JobTracker] CONFLICT:",
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
            "[JobTracker] Server belongs to this account:",
            currentJobId
        )

        return checkPlayerCount()
    end

    local targetPetExists = refreshTargetPetState()

    if targetPetExists then
        print("[PetTracker] Target pet found. Staying.")
    end

    local success = registerJob(
        LocalPlayer.Name,
        currentJobId
    )

    if success then
        print(
            "[JobTracker] Claimed:",
            LocalPlayer.Name,
            "->",
            currentJobId
        )

        return checkPlayerCount()
    end

    return false
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

EggCmds.AreaEggSnapshotUpdated:Connect(function(snapshot)
    LoadEggCache(snapshot)

    if hopping then
        return
    end

    if hasTargetPetFromCache() then
        print("[PetTracker] Target pet detected after snapshot update.")
        return
    end

    checkPlayerCount()
end)

EggCmds.AreaEggRemoved:Connect(function(uid)
    local assetCategory = eggCache[uid]

    print(
        "[PetTracker] Removed:",
        assetCategory or "Unknown",
        "| UID:",
        tostring(uid)
    )

    local wasTarget = assetCategory and isTargetPet(assetCategory)

    eggCache[uid] = nil

    if not wasTarget or hopping then
        return
    end

    task.defer(function()
        local targetStillExists = refreshTargetPetState()

        if targetStillExists then
            print("[PetTracker] Another target pet is still present.")
            return
        end

        print("[PetTracker] No target pets remain.")

        checkPlayerCount()
    end)
end)

checkCurrentServer()
