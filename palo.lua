repeat task.wait() until game:IsLoaded()

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local VIM = game:GetService("VirtualInputManager")
local LOCAL_PLAYER = Players.LocalPlayer

local function isMobile()
    return UserInputService.TouchEnabled
end

local function isPC()
    return UserInputService.KeyboardEnabled
        and UserInputService.MouseEnabled
        and not UserInputService.TouchEnabled
end

local function simulateTap()
    local camera = workspace.CurrentCamera
    if not camera then return end
    local viewport = camera.ViewportSize
    local x = 35
    local y = viewport.Y - 35
    if isMobile() then
        pcall(function()
            VIM:SendTouchEvent(1, 0, x, y)
            task.wait(0.08)
            VIM:SendTouchEvent(1, 2, x, y)
        end)
    elseif isPC() then
        pcall(function()
            VIM:SendMouseButtonEvent(x, y, 0, true, game, 1)
            task.wait(0.05)
            VIM:SendMouseButtonEvent(x, y, 0, false, game, 1)
        end)
    end
end

repeat
    simulateTap()
    task.wait(1)
until not LOCAL_PLAYER:GetAttribute("LoadingScreenActive") or LOCAL_PLAYER:GetAttribute("LoadingScreenDone") == true

loadstring(game:HttpGet("https://hybrid-e3.com/api/scripts/607034550f534374b8fc5feb1c6ef466/loader?key=PAID-4LJT-0PLB-VM3N-N1FY"))()
task.wait(2)
local CoreGui = game:GetService("CoreGui")

local obsidian
for _, v in ipairs(CoreGui:GetDescendants()) do
    if v.Name == "Obsidian" then
        obsidian = v
        break
    end
end

if not obsidian then
    warn("Obsidian not found")
    return
end

local container = obsidian.Main.Container
local frame = container:FindFirstChild("CanvasGroup")
    and container.CanvasGroup.Frame
    or container.Frame

local button = frame.ScrollingFrame:GetChildren()[5].Frame:GetChildren()[7].TextButton

local statusLabel = frame:GetChildren()[2]:GetChildren()[5].Frame:GetChildren()[7].TextLabel

local function click(btn)
    if not btn or not firesignal then
        return
    end

    pcall(firesignal, btn.Activated)
    pcall(firesignal, btn.MouseButton1Click)
    pcall(firesignal, btn.MouseButton1Down)
    pcall(firesignal, btn.MouseButton1Up)
end

local function ClickEnable()
    if statusLabel.Text == "Status : Off 🔴" then
        click(button)
    end
end

local function ClickDisable()
    if statusLabel.Text == "Status : On 🟢" then
        click(button)
    end
end
ClickEnable()
task.wait(1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Networking = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("Networking"))
local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts")
local NotificationController = require(
    game:GetService("Players").LocalPlayer.PlayerScripts.Controllers.NotificationController
)

NotificationController:CreateNotification(
    "Welcome to Jay Hub!", 
    Color3.fromRGB(71, 123, 255)
)

local WEBHOOK_URL = getgenv().Webhook or ""
local SEND_WEBHOOK = WEBHOOK_URL ~= ""
local TARGET_NAMES = getgenv().Pets
local TARGET_SIZES = getgenv().Size
local EGG_FARM = getgenv().Egg
if EGG_FARM == nil then
    EGG_FARM = false
end
local SPRINKLER_NAME = "Super Sprinkler"
local SEED_NAME = getgenv().Seeds or "Mega"
local CHECK_FRUIT_NAME = "Carrot"
local CHECK_FRUIT_MIN_KG = getgenv().KG or 40
local REJOIN_DELAY = 5
local CENTER_FORWARD_LENGTH = 27
local CENTER_RIGHT_LENGTH = 30
local RING_RADII = { 4, 8, 12 }
local RING_POINT_SPACING = 1.5
local RING_MIN_POINTS = 12
local PLACE_DELAY = 0.1
local CARROT_BEST_LOG_COOLDOWN = 5
local CARROT_SCAN_YIELD_EVERY = 25
local SPRINKLER_RECHECK_DELAY = 0.2
local SPRINKLER_CONFIRM_TIMEOUT = 3
local SPRINKLER_PLACE_COOLDOWN = 0
local SPRINKLER_MATCH_DISTANCE = 4
local EQUIP_RETRY_DELAY = 0.05

local GardenSyncController
local FruitVisualizerController
local lastSprinklerPlaceAttempt = 0
local lastCarrotBestLog = 0
local resolvedCenterPosition
local State = {
	Running = true,
	DepletedHandled = false,
	TargetFound = false
}

if _G.PlaceSuperSprinklerCarrotCircleState then
	_G.PlaceSuperSprinklerCarrotCircleState.Running = false
end
_G.PlaceSuperSprinklerCarrotCircleState = State

local function SendWebhook(title, description, color)
    if not SEND_WEBHOOK then
        return
    end

    local payload = {
        content = "@everyone",
        embeds = {{
            title = title,
            description = string.format(
                "**Player:** %s\n\n%s",
                LocalPlayer.Name,
                description
            ),
            color = color or 5763719, -- Discord Green (#57F287)
            footer = {
                text = "Made with ❤️ by Jay Hub"
            },
            timestamp = DateTime.now():ToIsoDate()
        }}
    }

    local ok, err = pcall(function()
        request({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(payload)
        })
    end)

    if not ok then
        warn("[Webhook Error]", err)
    end
end

local function containsAny(value, options)
    local lowered = tostring(value or ""):lower()
    for _, option in ipairs(options) do
        if lowered:find(tostring(option):lower(), 1, true) then
            return true, option
        end
    end
    return false
end

local function isTarget(name, requireSize)
    if not name then return false end

    if requireSize ~= false then
        local hasSize = containsAny(name, TARGET_SIZES)
        if not hasSize then return false end
    end

    local hasTarget = containsAny(name, TARGET_NAMES)
    return hasTarget == true
end

local function isVisibleGui(instance)
    local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local current = instance

    while current and current ~= playerGui do
        if current:IsA("ScreenGui") and not current.Enabled then
            return false
        end

        if current:IsA("GuiObject") and not current.Visible then
            return false
        end

        current = current.Parent
    end

    return true
end

local function getTextValue(instance)
    if instance and (instance:IsA("TextLabel") or instance:IsA("TextButton") or instance:IsA("TextBox")) then
        return tostring(instance.Text or "")
    end

    return nil
end

local function hasVisibleText(root, text)
    if not root then return false end
    local wanted = tostring(text or ""):lower()

    for _, instance in ipairs(root:GetDescendants()) do
        local value = getTextValue(instance)
        if value and isVisibleGui(instance) and value:lower():find(wanted, 1, true) then
            return true
        end
    end

    return false
end

local function isInActivePetRow(instance)
    local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local current = instance
    local depth = 0

    while current and current ~= playerGui and depth < 5 do
        if hasVisibleText(current, "UNEQUIP") then
            return true
        end

        current = current.Parent
        depth += 1
    end

    return false
end

local function checkActivePetGui()
    local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return false end

    for _, instance in ipairs(playerGui:GetDescendants()) do
        if (instance:IsA("TextLabel") or instance:IsA("TextButton") or instance:IsA("TextBox")) and isVisibleGui(instance) then
            local text = instance.Text
            if isTarget(text, false) and isInActivePetRow(instance) then
                print("FOUND TARGET IN ACTIVE UI: " .. tostring(text))
                return text
            end
        end
    end

    return false
end

local function checkBackpack()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    local character = LocalPlayer.Character

    local function scanContainer(container)
        if not container then return false end
        for _, item in ipairs(container:GetChildren()) do
            if (item:IsA("Tool") or item:IsA("Configuration")) and isTarget(item.Name) then
                print("FOUND TARGET: " .. item.Name)
                return item.Name
            end
        end
        return false
    end
    local pet = scanContainer(backpack) or scanContainer(character) or checkActivePetGui()
	
	return pet
end

local function run()
    local eggTool = LocalPlayer.Backpack:FindFirstChild("Common Egg")
    local count = eggTool and eggTool:GetAttribute("Count") or 0
    print("Egg count: " .. tostring(count))

    for i = 1, count do
        Networking.Egg.OpenEgg:Fire("Common Egg")
        print("Opened egg " .. i .. "/" .. count)
        task.wait(0.025)
    end

    print("Checking backpack...")
    task.wait(5)

    local petName = checkBackpack()

    if petName then
        print("Target pet found! Staying on server.")
        SendWebhook(
            "🥚 Target Pet Found!",
            string.format("**Pet:** %s", petName)
        )
        return true
    else
        print("No target found. Rejoining...")
        return false
    end
end

pcall(function()
	local controllers = PlayerScripts:WaitForChild("Controllers", 5)
	if controllers then
		GardenSyncController = require(controllers:WaitForChild("GardenSyncController", 5))
		local fruitVisualizerModule = controllers:FindFirstChild("FruitVisualizerController")
		if fruitVisualizerModule then
			FruitVisualizerController = require(fruitVisualizerModule)
		end
	end
end)

local function log(...)
	print("[PlaceSuperSprinklerCarrotCircle]", ...)
end

local function isActiveState()
	return _G.PlaceSuperSprinklerCarrotCircleState == State
end

local function normalizeName(value)
	return string.lower(tostring(value or "")):gsub("%s+", ""):gsub("[^%w]", "")
end

local function parseKgFromText(value)
	local text = tostring(value or ""):gsub(",", "")
	local numberText = text:match("(%d+%.?%d*)%s*[Kk][Gg]")
	return tonumber(numberText)
end

local function parseWeightKg(value, assumeGrams)
	if value == nil then
		return nil
	end

	if type(value) == "number" then
		if assumeGrams and value > 1000 then
			return value / 1000
		end
		return value
	end

	local kg = parseKgFromText(value)
	if kg then
		return kg
	end

	local number = tonumber(tostring(value):gsub(",", ""))
	if not number then
		return nil
	end

	if assumeGrams and number > 1000 then
		return number / 1000
	end

	return number
end

local function getAttrNumber(instance, names)
	if not instance then
		return nil
	end

	for _, name in ipairs(names) do
		local value = instance:GetAttribute(name)
		if value ~= nil then
			if type(value) == "number" then
				return value
			end

			local number = parseWeightKg(value)
			if number then
				return number
			end
		end
	end

	return nil
end

local WEIGHT_ATTRS = {
	"Kg",
	"WeightKg",
	"Kilograms",
	"Weight",
	"Mass",
	"Grams",
	"WeightGrams"
}

local SIZE_ATTRS = {
	"SizeMultiplier",
	"SizeMulti",
	"Size",
	"WeightMultiplier",
	"Scale"
}

local FRUIT_DATA_NAME_FIELDS = {
	"CorePartName",
	"FruitName",
	"Fruit",
	"Name",
	"DisplayName",
	"ItemName",
	"SeedName",
	"Seed"
}

local PLANT_DATA_NAME_FIELDS = {
	"CorePartName",
	"PlantName",
	"SeedName",
	"FruitName",
	"Fruit",
	"Name",
	"DisplayName",
	"ItemName",
	"Seed"
}

local OVERTIME_ATTRS = {
	"OvertimeGrowth"
}

local FruitBaseWeights = {}

local function getTextWeight(instance)
	if not instance then
		return nil
	end

	local direct = parseKgFromText(instance.Name)
	if direct then
		return direct
	end

	for _, child in ipairs(instance:GetDescendants()) do
		if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
			local weight = parseKgFromText(child.Text)
			if weight then
				return weight
			end
		end
	end

	return nil
end

local function calculateModelWeightKg(fruitModel, plantModel)
	if FruitVisualizerController and fruitModel then
		local visualizerWeight
		pcall(function()
			if FruitVisualizerController.CalculateFruitWeight then
				visualizerWeight = FruitVisualizerController:CalculateFruitWeight(fruitModel)
			end
		end)

		if not visualizerWeight and plantModel then
			pcall(function()
				if FruitVisualizerController.CalculatePlantWeight then
					visualizerWeight = FruitVisualizerController:CalculatePlantWeight(plantModel)
				end
			end)
		end

		local kg = parseWeightKg(visualizerWeight, true)
		if kg then
			return kg
		end
	end

	return getAttrNumber(fruitModel, WEIGHT_ATTRS)
		or getTextWeight(fruitModel)
		or getAttrNumber(plantModel, WEIGHT_ATTRS)
		or getTextWeight(plantModel)
end

local function getTextAttribute(instance, names)
	if not instance then
		return nil
	end

	for _, name in ipairs(names) do
		local value = instance:GetAttribute(name)
		if value ~= nil and tostring(value) ~= "" then
			return tostring(value)
		end
	end

	return nil
end

local function getFruitName(fruitModel, plantModel)
	local name = getTextAttribute(fruitModel, { "CorePartName", "FruitName", "SeedName", "Fruit", "Name" })
		or getTextAttribute(plantModel, { "SeedName", "FruitName", "Fruit", "Name" })
		or (fruitModel and fruitModel.Name)
		or "Fruit"

	local parsed = tostring(name):match("^(.-)%s*%[")
	return tostring(parsed and parsed ~= "" and parsed or name)
end

local function cleanFruitName(value)
	local text = tostring(value or "")
	text = text:gsub("%b[]", " ")
	text = text:gsub("%d+%.?%d*%s*[Kk][Gg]", " ")
	text = text:gsub("^%s+", ""):gsub("%s+$", ""):gsub("%s+", " ")
	return text
end

local NAME_ATTRS = {
	"CorePartName",
	"FruitName",
	"Fruit",
	"Name",
	"DisplayName",
	"ItemName",
	"SeedName",
	"Seed"
}

local function addNameCandidate(candidates, value)
	if value == nil then
		return
	end

	local cleaned = cleanFruitName(value)
	if cleaned ~= "" then
		table.insert(candidates, cleaned)
	end
end

local function collectNameCandidates(instance, candidates)
	if not instance then
		return
	end

	for _, attrName in ipairs(NAME_ATTRS) do
		addNameCandidate(candidates, instance:GetAttribute(attrName))
	end

	addNameCandidate(candidates, instance.Name)

	for _, child in ipairs(instance:GetDescendants()) do
		if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
			addNameCandidate(candidates, child.Text)
		end
	end
end

local function fruitMatchesTargetName(fruitModel, plantModel)
	local targetName = normalizeName(CHECK_FRUIT_NAME)
	local candidates = {}
	collectNameCandidates(fruitModel, candidates)
	collectNameCandidates(plantModel, candidates)

	for _, candidate in ipairs(candidates) do
		local normalized = normalizeName(candidate)
		if normalized == targetName or string.find(normalized, targetName, 1, true) then
			return true, candidate
		end
	end

	return false, getFruitName(fruitModel, plantModel)
end

local function Rejoin()
	local player = Players.LocalPlayer
	if player then
		TeleportService:Teleport(game.PlaceId, player)
	end
end

local function getPlot()
	local gardens = workspace:FindFirstChild("Gardens")
	if not gardens then
		return nil, "workspace.Gardens not found"
	end

	local plotId = LocalPlayer:GetAttribute("PlotId")
	if not plotId then
		return nil, "LocalPlayer PlotId not found"
	end

	local plot = gardens:FindFirstChild("Plot" .. tostring(plotId))
	if not plot then
		return nil, "Plot" .. tostring(plotId) .. " not found"
	end

	return plot
end

local function getPlotId(plot)
	return plot and tonumber(tostring(plot.Name):match("%d+"))
end

local function getPlantAreaParts(plot)
	local parts = {}

	for _, part in ipairs(CollectionService:GetTagged("PlantArea")) do
		if part:IsA("BasePart") and part:IsDescendantOf(plot) then
			table.insert(parts, part)
		end
	end

	if #parts > 0 then
		return parts
	end

	for _, descendant in ipairs(plot:GetDescendants()) do
		if descendant:IsA("BasePart") and CollectionService:HasTag(descendant, "PlantArea") then
			table.insert(parts, descendant)
		end
	end

	return parts
end

local function projectToPlantArea(plot, position)
	local parts = getPlantAreaParts(plot)
	if #parts == 0 then
		return nil, "no PlantArea parts found in your plot"
	end

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	params.FilterDescendantsInstances = parts

	local origin = Vector3.new(position.X, position.Y + 120, position.Z)
	local result = workspace:Raycast(origin, Vector3.new(0, -260, 0), params)
	if not result then
		return nil, "raycast did not hit PlantArea"
	end

	return result.Position
end

local function findTool(attributeName, attributeValue)
	local containers = {
		LocalPlayer.Character,
		LocalPlayer:FindFirstChild("Backpack")
	}

	local wantedName = normalizeName(attributeValue)

	for _, container in ipairs(containers) do
		if container then
			for _, item in ipairs(container:GetChildren()) do
				local matchesAttribute = item:IsA("Tool") and item:GetAttribute(attributeName) == attributeValue
				local matchesName = item:IsA("Tool")
					and type(attributeValue) == "string"
					and normalizeName(item.Name) == wantedName

				if matchesAttribute or matchesName then
					local count = tonumber(item:GetAttribute("Count"))
					if count == nil or count > 0 then
						return item
					end
				end
			end
		end
	end

	return nil
end

local function getToolSeedName(tool)
	if not (tool and tool:IsA("Tool")) then
		return nil
	end

	local seedName = tool:GetAttribute("SeedTool")
		or tool:GetAttribute("SeedName")
		or tool:GetAttribute("Seed")

	if type(seedName) == "string" and seedName ~= "" then
		return seedName
	end

	return nil
end

local function equipTool(tool)
	if not tool then
		return false
	end

	local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	if tool.Parent == character then
		return true
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return false
	end

	for _ = 1, 3 do
		pcall(function()
			humanoid:EquipTool(tool)
		end)

		local startedAt = os.clock()
		while os.clock() - startedAt < 1 do
			if tool.Parent == character then
				task.wait(0.03)
				return true
			end
			task.wait(EQUIP_RETRY_DELAY)
		end
	end

	return tool.Parent == character
end

local function waitForGardenSync()
	if not GardenSyncController then
		return false
	end

	if GardenSyncController.IsLocalGardenLoaded and GardenSyncController:IsLocalGardenLoaded() then
		return true
	end

	if GardenSyncController.WaitForLocalGardenLoaded then
		local ok = pcall(function()
			GardenSyncController:WaitForLocalGardenLoaded()
		end)
		return ok
	end

	return false
end

local function placeSprinkler(plot, position)
	local plotId = getPlotId(plot)
	if not plotId then
		return false, "plot id not found"
	end

	local sprinklerTool = findTool("Sprinkler", SPRINKLER_NAME)
	if not sprinklerTool then
		return false, SPRINKLER_NAME .. " tool not found"
	end

	if not equipTool(sprinklerTool) then
		return false, "failed to equip " .. SPRINKLER_NAME
	end

	lastSprinklerPlaceAttempt = os.clock()
	Networking.Place.PlaceSprinkler:Fire(position, SPRINKLER_NAME, sprinklerTool, plotId)
	return true
end

local function getSyncedSprinklers()
	if not GardenSyncController or not GardenSyncController.GetSprinklers then
		return nil
	end

	local ok, sprinklers = pcall(function()
		return GardenSyncController:GetSprinklers(LocalPlayer.UserId)
	end)

	if ok and type(sprinklers) == "table" then
		return sprinklers
	end

	return nil
end

local function getSyncedSprinklerWorldPosition(plot, sprinklerData)
	local positions = sprinklerData and sprinklerData.Positions
	local primaryPart = plot and plot.PrimaryPart
	if not (positions and primaryPart) then
		return nil
	end

	local localPosition = Vector3.new(
		tonumber(positions.PosX) or 0,
		tonumber(positions.PosY) or 0,
		tonumber(positions.PosZ) or 0
	)

	return primaryPart.CFrame:PointToWorldSpace(localPosition)
end

local function hasSuperSprinkler(plot, position)
	local syncedSprinklers = getSyncedSprinklers()
	if syncedSprinklers then
		for _, sprinklerData in pairs(syncedSprinklers) do
			local sprinklerName = sprinklerData.SprinklerName
				or sprinklerData.ItemName
				or sprinklerData.Name

			if tostring(sprinklerName) == SPRINKLER_NAME then
				if not position then
					return true
				end

				local worldPosition = getSyncedSprinklerWorldPosition(plot, sprinklerData)
				if worldPosition and (worldPosition - position).Magnitude <= SPRINKLER_MATCH_DISTANCE then
					return true
				end
			end
		end
	end

	local sprinklersFolder = plot and plot:FindFirstChild("Sprinklers")
	if not sprinklersFolder then
		return false
	end

	for _, child in ipairs(sprinklersFolder:GetChildren()) do
		if child:IsA("Model") or child:IsA("BasePart") or child:IsA("Folder") then
			local sprinklerName = child:GetAttribute("Sprinkler")
				or child:GetAttribute("ItemName")
				or child:GetAttribute("Name")
				or child.Name
			if tostring(sprinklerName) == SPRINKLER_NAME or string.find(string.lower(tostring(sprinklerName)), "super sprinkler", 1, true) then
				if not position then
					return true
				end

				local part = child:IsA("BasePart") and child
					or child.PrimaryPart
					or child:FindFirstChildWhichIsA("BasePart", true)

				if part and (part.Position - position).Magnitude <= SPRINKLER_MATCH_DISTANCE then
					return true
				end
			end
		end
	end

	return false
end

local function waitForTargetSprinkler(plot, position, timeout)
	local deadline = os.clock() + math.max(timeout or SPRINKLER_CONFIRM_TIMEOUT, SPRINKLER_RECHECK_DELAY)
	while os.clock() < deadline do
		if hasSuperSprinkler(plot, position) then
			return true
		end
		task.wait(SPRINKLER_RECHECK_DELAY)
	end

	return hasSuperSprinkler(plot, position)
end

local function ensureSuperSprinkler(plot, position)
	if hasSuperSprinkler(plot, position) then
		return true
	end

	waitForGardenSync()

	if hasSuperSprinkler(plot, position) then
		return true
	end

	if os.clock() - lastSprinklerPlaceAttempt < SPRINKLER_PLACE_COOLDOWN then
		return false, "waiting for sprinkler sync"
	end

	local placed, err = placeSprinkler(plot, position)
	if not placed then
		return false, err
	end

	if waitForTargetSprinkler(plot, position, SPRINKLER_CONFIRM_TIMEOUT) then
		return true
	end

	return false, "sprinkler placement not confirmed yet"
end

local function getSeedTool(seedName)
	local containers = {
		LocalPlayer.Character,
		LocalPlayer:FindFirstChild("Backpack")
	}

	local wantedName = normalizeName(seedName)

	for _, container in ipairs(containers) do
		if container then
			for _, item in ipairs(container:GetChildren()) do
				local itemSeedName = getToolSeedName(item)
				local itemName = item:IsA("Tool") and normalizeName(item.Name) or nil
				if item:IsA("Tool") and ((itemSeedName and normalizeName(itemSeedName) == wantedName) or itemName == wantedName) then
					local count = tonumber(item:GetAttribute("Count"))
					if count == nil or count > 0 then
						return item
					end
				end
			end
		end
	end

	return nil
end

local function safeRequire(module)
	if not (module and module:IsA("ModuleScript")) then
		return nil
	end

	local ok, result = pcall(require, module)
	if ok then
		return result
	end

	return nil
end

local function getDataField(data, names)
	if type(data) ~= "table" then
		return nil
	end

	for _, name in ipairs(names) do
		local value = data[name]
		if value ~= nil then
			return value
		end
	end

	return nil
end

local function getDataNumber(data, names)
	if type(data) ~= "table" then
		return nil
	end

	for _, name in ipairs(names) do
		local value = data[name]
		if value ~= nil then
			if type(value) == "number" then
				return value
			end

			local number = tonumber(tostring(value):gsub(",", "")) or parseKgFromText(value)
			if number then
				return number
			end
		end
	end

	return nil
end

local function normalizeWeightKg(value, valueIsGrams)
	if value == nil then
		return nil
	end

	local textKg = parseKgFromText(value)
	if textKg then
		return textKg
	end

	local number
	if type(value) == "number" then
		number = value
	else
		number = tonumber(tostring(value):gsub(",", ""))
	end

	if not number or number <= 0 then
		return nil
	end

	if valueIsGrams then
		return number / 1000
	end

	return number
end

local function getWeightAttrKg(instance)
	if not instance then
		return nil
	end

	for _, name in ipairs(WEIGHT_ATTRS) do
		local value = instance:GetAttribute(name)
		if value ~= nil then
			local valueIsGrams = name == "Grams" or name == "WeightGrams"
			local kg = normalizeWeightKg(value, valueIsGrams)
			if kg then
				return kg
			end
		end
	end

	return nil
end

local function getDataWeightKg(data)
	if type(data) ~= "table" then
		return nil
	end

	for _, name in ipairs(WEIGHT_ATTRS) do
		local value = data[name]
		if value ~= nil then
			local valueIsGrams = name == "Grams" or name == "WeightGrams"
			local kg = normalizeWeightKg(value, valueIsGrams)
			if kg then
				return kg
			end
		end
	end

	return nil
end

local function getFruitBaseWeight(name)
	local cleanedName = cleanFruitName(name)
	local cacheKey = normalizeName(cleanedName)
	if cacheKey == "" then
		return nil
	end

	if FruitBaseWeights[cacheKey] ~= nil then
		return FruitBaseWeights[cacheKey] or nil
	end

	local generationModules = ReplicatedStorage:FindFirstChild("PlantGenerationModules")
	local fruitsFolder = generationModules and generationModules:FindFirstChild("Fruits")
	if not fruitsFolder then
		return nil
	end

	local fruitModule = fruitsFolder:FindFirstChild(cleanedName)
	if not (fruitModule and fruitModule:IsA("ModuleScript")) then
		for _, descendant in ipairs(fruitsFolder:GetDescendants()) do
			if descendant:IsA("ModuleScript") and normalizeName(descendant.Name) == cacheKey then
				fruitModule = descendant
				break
			end
		end
	end

	local baseWeight
	local data = safeRequire(fruitModule)
	if type(data) == "table" then
		local growData = data.GrowData
		baseWeight = growData and tonumber(growData.BaseWeight)
	end

	if baseWeight then
		FruitBaseWeights[cacheKey] = baseWeight
	end

	return baseWeight
end

local function calculateDataWeightKg(name, fruitData, plantData)
	local baseWeight = getFruitBaseWeight(name)
		or getFruitBaseWeight(getDataField(plantData, PLANT_DATA_NAME_FIELDS))

	if baseWeight then
		local size = getDataNumber(fruitData, SIZE_ATTRS)
			or getDataNumber(plantData, SIZE_ATTRS)
			or 1
		local overtime = getDataNumber(fruitData, OVERTIME_ATTRS)
			or getDataNumber(plantData, OVERTIME_ATTRS)
			or 1

		return baseWeight * size * overtime
	end

	return getDataWeightKg(fruitData) or getDataWeightKg(plantData)
end

local function getGardenData()
	if not (GardenSyncController and LocalPlayer) then
		return nil
	end

	local garden
	pcall(function()
		if GardenSyncController.GetGarden then
			garden = GardenSyncController:GetGarden(LocalPlayer.UserId)
		end
	end)

	return type(garden) == "table" and garden or nil
end

local function valueMatchesTargetName(value)
	if value == nil then
		return false
	end

	local cleaned = cleanFruitName(value)
	if cleaned == "" then
		return false
	end

	local targetName = normalizeName(CHECK_FRUIT_NAME)
	local normalized = normalizeName(cleaned)
	if normalized == targetName or string.find(normalized, targetName, 1, true) then
		return true, cleaned
	end

	return false
end

local function dataMatchesTargetName(data, names)
	if type(data) ~= "table" then
		return false
	end

	for _, name in ipairs(names) do
		local matched, cleaned = valueMatchesTargetName(data[name])
		if matched then
			return true, cleaned
		end
	end

	return false
end

local function getDataFruitName(fruitData, plantData)
	local name = getDataField(fruitData, FRUIT_DATA_NAME_FIELDS)
		or getDataField(plantData, PLANT_DATA_NAME_FIELDS)
		or CHECK_FRUIT_NAME
	return cleanFruitName(name)
end

local function directNameMatchesTarget(instance)
	if not instance then
		return false
	end

	for _, attrName in ipairs(NAME_ATTRS) do
		local matched, cleaned = valueMatchesTargetName(instance:GetAttribute(attrName))
		if matched then
			return true, cleaned
		end
	end

	return valueMatchesTargetName(instance.Name)
end

local function getFastWeightKg(instance)
	if not instance then
		return nil
	end

	return getWeightAttrKg(instance) or parseKgFromText(instance.Name)
end

local function calculateCandidateWeightKg(fruitModel, plantModel)
	local quickWeight = getFastWeightKg(fruitModel) or getFastWeightKg(plantModel)
	if quickWeight then
		return quickWeight
	end

	if FruitVisualizerController and fruitModel then
		local visualizerWeight
		pcall(function()
			if FruitVisualizerController.CalculateFruitWeight then
				visualizerWeight = FruitVisualizerController:CalculateFruitWeight(fruitModel)
			end
		end)

		if not visualizerWeight and plantModel then
			pcall(function()
				if FruitVisualizerController.CalculatePlantWeight then
					visualizerWeight = FruitVisualizerController:CalculatePlantWeight(plantModel)
				end
			end)
		end

		return normalizeWeightKg(visualizerWeight, false)
	end

	return nil
end

local function addCarrotCandidate(candidates, seen, fruitModel, plantModel, fruitName)
	local instance = fruitModel or plantModel
	if not instance or seen[instance] then
		return
	end

	seen[instance] = true
	table.insert(candidates, {
		Name = fruitName or getFruitName(fruitModel, plantModel),
		FruitModel = fruitModel,
		PlantModel = plantModel
	})
end

local function collectDirectCarrotCandidates(plants)
	local candidates = {}
	local seen = {}

	for index, plant in ipairs(plants:GetChildren()) do
		if plant:IsA("Model") or plant:IsA("Folder") then
			local plantMatches, plantName = directNameMatchesTarget(plant)
			if plantMatches then
				addCarrotCandidate(candidates, seen, plant, plant, plantName)
			end

			for _, child in ipairs(plant:GetChildren()) do
				if child:IsA("Model") or child:IsA("BasePart") then
					local childMatches, childName = directNameMatchesTarget(child)
					if childMatches or plantMatches then
						addCarrotCandidate(candidates, seen, child, plant, childName or plantName)
					end
				elseif child:IsA("Folder") and string.find(normalizeName(child.Name), "fruit", 1, true) then
					for _, fruit in ipairs(child:GetChildren()) do
						if fruit:IsA("Model") or fruit:IsA("BasePart") then
							local fruitMatches, fruitName = directNameMatchesTarget(fruit)
							if fruitMatches or plantMatches then
								addCarrotCandidate(candidates, seen, fruit, plant, fruitName or plantName)
							end
						end
					end
				end
			end
		end

		if index % CARROT_SCAN_YIELD_EVERY == 0 then
			task.wait()
		end
	end

	return candidates
end

local function updateBestCarrotCandidate(bestCandidate, name, weight, instance, source)
	if not weight then
		return bestCandidate
	end

	if not bestCandidate or weight > bestCandidate.Weight then
		return {
			Name = name,
			Weight = weight,
			Instance = instance,
			Source = source
		}
	end

	return bestCandidate
end

local function logBestCarrotCandidate(bestCandidate, logBest)
	if bestCandidate and logBest and os.clock() - lastCarrotBestLog >= CARROT_BEST_LOG_COOLDOWN then
		lastCarrotBestLog = os.clock()
		log(("best %s found but not over target | %.2fkg <= %.2fkg | source=%s | %s"):format(
			CHECK_FRUIT_NAME,
			tonumber(bestCandidate.Weight) or 0,
			CHECK_FRUIT_MIN_KG,
			tostring(bestCandidate.Source or "?"),
			bestCandidate.Instance and bestCandidate.Instance:GetFullName() or "GardenSync"
		))
	end
end

local function findHeavyCarrotInGardenData(logBest)
	local gardenData = getGardenData()
	if type(gardenData) ~= "table" or next(gardenData) == nil then
		return nil, false
	end

	local bestCandidate
	local scanned = 0

	local function checkDataFruit(name, fruitData, plantData)
		local weight = calculateDataWeightKg(name, fruitData, plantData)
		bestCandidate = updateBestCarrotCandidate(bestCandidate, name, weight, nil, "GardenSync")

		if weight and weight > CHECK_FRUIT_MIN_KG then
			if not State.TargetFound then
				State.TargetFound = true
				ClickDisable()
				SendWebhook("🎉 Carrot Achieved!",string.format("**Fruit:** %s\n**Weight:** %.2fkg", name, weight))
				task.delay(1, function() LocalPlayer:Kick(string.format("Target reached!\n%s: %.2fkg", name, weight ))
				    end)
			end
			return {
				Name = name,
				Weight = weight,
				Instance = nil,
				Source = "GardenSync"
			}
		end

		return nil
	end

	for _, plantData in pairs(gardenData) do
		if not isActiveState() then
			return nil, true
		end

		if type(plantData) == "table" then
			local plantMatches, plantName = dataMatchesTargetName(plantData, PLANT_DATA_NAME_FIELDS)
			local fruits = plantData.Fruits

			if type(fruits) == "table" and next(fruits) ~= nil then
				for _, fruitData in pairs(fruits) do
					if type(fruitData) == "table" then
						local fruitMatches, fruitName = dataMatchesTargetName(fruitData, FRUIT_DATA_NAME_FIELDS)
						if fruitMatches or plantMatches then
							local found = checkDataFruit(fruitName or plantName or getDataFruitName(fruitData, plantData), fruitData, plantData)
							if found then
								return found, true
							end
						end
					end

					scanned += 1
					if scanned % CARROT_SCAN_YIELD_EVERY == 0 then
						task.wait()
					end
				end
			elseif plantMatches then
				local found = checkDataFruit(plantName or getDataFruitName(nil, plantData), nil, plantData)
				if found then
					return found, true
				end

				scanned += 1
				if scanned % CARROT_SCAN_YIELD_EVERY == 0 then
					task.wait()
				end
			end
		end
	end

	logBestCarrotCandidate(bestCandidate, logBest)
	return nil, true
end

local function findHeavyCarrotInGarden(plot, logBest)
	local foundFromData, usedGardenData = findHeavyCarrotInGardenData(logBest)
	if foundFromData or usedGardenData then
		return foundFromData
	end

	local plants = plot and plot:FindFirstChild("Plants")
	if not plants then
		return nil
	end

	local bestCandidate
	local candidates = collectDirectCarrotCandidates(plants)

	for index, candidate in ipairs(candidates) do
		if not isActiveState() then
			return nil
		end

		local weight = calculateCandidateWeightKg(candidate.FruitModel, candidate.PlantModel)
		bestCandidate = updateBestCarrotCandidate(
			bestCandidate,
			candidate.Name,
			weight,
			candidate.FruitModel or candidate.PlantModel,
			"Model"
		)

		if weight and weight > CHECK_FRUIT_MIN_KG then
			if not State.TargetFound then
				State.TargetFound = true
				ClickDisable()
				SendWebhook("🎉 Carrot Achieved!",string.format("**Fruit:** %s\n**Weight:** %.2fkg",candidate.Name,weight ))
				task.delay(1, function() LocalPlayer:Kick(string.format("Target reached!\n%s: %.2fkg", candidate.Name, weight ))
				    end)
			end
			return {
				Name = candidate.Name,
				Weight = weight,
				Instance = candidate.FruitModel or candidate.PlantModel,
				Source = "Model"
			}
		end

		if index % CARROT_SCAN_YIELD_EVERY == 0 then
			task.wait()
		end
	end

	logBestCarrotCandidate(bestCandidate, logBest)

	return nil
end

local function handleSeedDepleted(plot)
    if State.DepletedHandled then
        return
    end

    State.DepletedHandled = true
    State.Running = false

    if State.TargetFound then
        log(("Target %s %.2fkg found | finishing run"):format(
            CHECK_FRUIT_NAME,
            CHECK_FRUIT_MIN_KG
        ))
    else
        log(("%s depleted | checking %s > %.2fkg"):format(
            SEED_NAME,
            CHECK_FRUIT_NAME,
            CHECK_FRUIT_MIN_KG
        ))
    end

    local foundCarrot = findHeavyCarrotInGarden(plot, true)

    if foundCarrot then
        log(("Found %s %.2fkg"):format(
            foundCarrot.Name,
            foundCarrot.Weight
        ))
    end

    if EGG_FARM then
        local foundPet = run()

        if foundPet then
            return
        end
    end

    if foundCarrot then
        return
    end

    log(("%s depleted and no %s > %.2fkg found | rejoining in %d seconds"):format(
        SEED_NAME,
        CHECK_FRUIT_NAME,
        CHECK_FRUIT_MIN_KG,
        REJOIN_DELAY
    ))

    task.wait(REJOIN_DELAY)

    if not isActiveState() then
        return
    end

    foundCarrot = findHeavyCarrotInGarden(plot, false)

    if foundCarrot then
        log(("Found %s %.2fkg before rejoin"):format(
            foundCarrot.Name,
            foundCarrot.Weight
        ))
        return
    end

    if EGG_FARM then
        local foundPet = run()
        if foundPet then
            return
        end
    end

    if isActiveState() then
        Rejoin()
    end
end

local function plantSeedAt(position, seedName)
	local seedTool = getSeedTool(seedName)
	if not seedTool then
		return false, seedName .. " seed tool not found"
	end

	if not equipTool(seedTool) then
		return false, "failed to equip " .. seedName
	end

	local actualSeedName = getToolSeedName(seedTool) or seedName
	local ok, err = pcall(function()
		Networking.Plant.PlantSeed:Fire(position, actualSeedName, seedTool)
	end)
	if not ok then
		return false, tostring(err)
	end

	return true
end

local function getRingPointCount(radius)
	local circumference = math.pi * 2 * radius
	return math.max(RING_MIN_POINTS, math.floor((circumference / RING_POINT_SPACING) + 0.5))
end

local function buildCircleOffsets(radius, pointCount, startAngle)
	local offsets = {}
	startAngle = startAngle or 0

	for index = 1, pointCount do
		local angle = startAngle + (((index - 1) / pointCount) * math.pi * 2)
		table.insert(offsets, Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius))
	end

	return offsets
end

local function buildRingRadii()
	local radii = {}

	for _, radius in ipairs(RING_RADII) do
		radius = tonumber(radius)
		if radius and radius > 0 then
			table.insert(radii, radius)
		end
	end

	return radii
end

local function buildPlantPositions(plot, centerPosition)
	local positions = {}
	local seen = {}
	local radii = buildRingRadii()

	for ringIndex, radius in ipairs(radii) do
		local pointCount = getRingPointCount(radius)
		local stepAngle = (math.pi * 2) / pointCount
		local startAngle = (ringIndex % 2 == 0) and 0 or (stepAngle * 0.5)
		local ringOffsets = buildCircleOffsets(radius, pointCount, startAngle)

		for _, offset in ipairs(ringOffsets) do
			local projected, err = projectToPlantArea(plot, centerPosition + offset)
			if projected then
				local key = string.format("%.2f|%.2f|%.2f", projected.X, projected.Y, projected.Z)
				if not seen[key] then
					seen[key] = true
					table.insert(positions, projected)
				end
			else
				log("skip point:", err)
			end
		end
	end

	return positions
end

local function getDynamicCenterPosition()
	if resolvedCenterPosition then
		return resolvedCenterPosition
	end

	local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local hrp = character and character:WaitForChild("HumanoidRootPart", 5)
	if not hrp then
		return nil, "HumanoidRootPart not found"
	end

	resolvedCenterPosition = (hrp.CFrame * CFrame.new(CENTER_RIGHT_LENGTH, 0, -CENTER_FORWARD_LENGTH)).Position
	return resolvedCenterPosition
end

local function getTargetSetup()
	local plot, plotError = getPlot()
	if not plot then
		return nil, nil, nil, plotError
	end

	local centerPosition, centerError = getDynamicCenterPosition()
	if not centerPosition then
		return plot, nil, nil, centerError
	end

	local sprinklerPosition, projectError = projectToPlantArea(plot, centerPosition)
	if not sprinklerPosition then
		return plot, nil, nil, projectError
	end

	local plantPositions = buildPlantPositions(plot, sprinklerPosition)
	if #plantPositions == 0 then
		return plot, sprinklerPosition, nil, "no plant positions available around sprinkler"
	end

	return plot, sprinklerPosition, plantPositions, nil
end

local lastStateKey
local function logStateOnce(key, message)
	if lastStateKey ~= key then
		lastStateKey = key
		log(message)
	end
end

local function clearStateLog()
	lastStateKey = nil
end

local lastSetupSignature
local totalPlantRequests = 0
local cyclePlantRequests = 0
local positionIndex = 1
local plantPositions = {}
local currentSprinklerPosition

local function CheckGardenForTargetCarrot()
    local gardenData = getGardenData()
    if type(gardenData) ~= "table" then
        return false
    end

    for _, plantData in pairs(gardenData) do
        if type(plantData) == "table" then
            local plantMatches, plantName = dataMatchesTargetName(plantData, PLANT_DATA_NAME_FIELDS)
            local fruits = plantData.Fruits

            if type(fruits) == "table" then
                for _, fruitData in pairs(fruits) do
                    if type(fruitData) == "table" then
                        local fruitMatches, fruitName = dataMatchesTargetName(fruitData, FRUIT_DATA_NAME_FIELDS)

                        if fruitMatches or plantMatches then
                            local name = fruitName or plantName or getDataFruitName(fruitData, plantData)
                            local weight = calculateDataWeightKg(name, fruitData, plantData)

                            if weight and weight > CHECK_FRUIT_MIN_KG then
                                LocalPlayer:Kick(string.format(
                                    "Target reached!\n%s: %.2fkg",
                                    name,
                                    weight
                                ))
                                return true
                            end
                        end
                    end
                end
            end
        end
    end

    return false
end

if CheckGardenForTargetCarrot() then
    return
end

while State.Running do
	local plot, sprinklerPosition, newPlantPositions, setupError = getTargetSetup()
	if setupError then
		logStateOnce("setup:" .. tostring(setupError), tostring(setupError))
		task.wait(1)
		continue
	end

	if not getSeedTool(SEED_NAME) then
		handleSeedDepleted(plot)
		break
	end

	local setupSignature = string.format(
		"%s|%.3f|%.3f|%.3f|%d",
		plot:GetFullName(),
		sprinklerPosition.X,
		sprinklerPosition.Y,
		sprinklerPosition.Z,
		#newPlantPositions
	)

	if setupSignature ~= lastSetupSignature then
		lastSetupSignature = setupSignature
		currentSprinklerPosition = sprinklerPosition
		plantPositions = newPlantPositions
		positionIndex = 1
		cyclePlantRequests = 0

		log(("target ready | %s at %.3f, %.3f, %.3f | %s points=%d"):format(
			SPRINKLER_NAME,
			sprinklerPosition.X,
			sprinklerPosition.Y,
			sprinklerPosition.Z,
			SEED_NAME,
			#plantPositions
		))
	end

	local sprinklerReady, sprinklerReadyError = ensureSuperSprinkler(plot, currentSprinklerPosition)
	if not sprinklerReady then
		logStateOnce(
			"sprinkler:" .. tostring(sprinklerReadyError),
			"sprinkler missing | " .. tostring(sprinklerReadyError)
		)
		task.wait(math.max(SPRINKLER_RECHECK_DELAY, 0.2))
		continue
	end

	clearStateLog()

	if State.TargetFound then
		State.Running = false
		log("Target carrot found. Stopping planting and preserving remaining seeds.")
		break
	end

	if positionIndex > #plantPositions then
		if not getSeedTool(SEED_NAME) then
			handleSeedDepleted(plot)
			break
		end

		positionIndex = 1
		cyclePlantRequests = 0

		log(("Starting another %s planting pass..."):format(SEED_NAME))
	end

	local position = plantPositions[positionIndex]
	positionIndex += 1

	local ok, err = plantSeedAt(position, SEED_NAME)

	if ok then
		totalPlantRequests += 1
		cyclePlantRequests += 1

		if cyclePlantRequests == 1 or totalPlantRequests % #plantPositions == 0 then
			log(("%s loop running | total requests=%d"):format(
				SEED_NAME,
				totalPlantRequests
			))
		end
	else
		if not getSeedTool(SEED_NAME) then
			handleSeedDepleted(plot)
			break
		end

		logStateOnce(
			"plant:" .. tostring(err),
			SEED_NAME .. " paused | " .. tostring(err)
		)

		task.wait(0.5)
	end

	task.wait(PLACE_DELAY)
end

if _G.PlaceSuperSprinklerCarrotCircleState == State then
	_G.PlaceSuperSprinklerCarrotCircleState = nil
end
