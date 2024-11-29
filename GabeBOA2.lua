-- Gabe Boa Auto-Farming Script
-- Description: Auto-farming features with teleport functionality and other utilities.

-- Variables to manage the toggle state
local autoFarmingEnabled = false
local customGUIs = {} -- Track custom GUI objects for cleanup
local customSounds = {} -- Track custom sound objects for cleanup

-- Function to create and show GUI
local function createAndShowGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GabeBoaGUI" -- Name to identify later for cleanup
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    table.insert(customGUIs, screenGui)

    for i = 0, 10 do
        local textLabel = Instance.new("TextLabel")
        textLabel.Text = "Gabe is so BOAAAA"
        textLabel.Size = UDim2.new(1, 0, 0.1, 0)
        textLabel.Position = UDim2.new(0, 0, 0.1 * i, 0)
        textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        textLabel.TextSize = 50
        textLabel.BackgroundTransparency = 1
        textLabel.TextStrokeTransparency = 0.5
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.Parent = screenGui
    end

    wait(3)
    screenGui:Destroy()
end

-- Function to play sound
local function playSound()
    local sound = Instance.new("Sound")
    sound.Name = "GabeBoaSound" -- Name to identify later for cleanup
    sound.SoundId = "rbxassetid://2820356263"
    sound.Parent = game.Workspace
    sound.Looped = true
    sound.Volume = 10
    sound:Play()
    table.insert(customSounds, sound)
end

-- Function to select and spawn the character
local function selectAndSpawnCharacter()
    local args = {
        [1] = "RequestCharacter",
        [2] = "InvisibleWoman",
        [3] = "Default"
    }

    pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("Network"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
    end)
end

-- Function to teleport to a specific location
local function teleportToLocation(location)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart = player.Character.HumanoidRootPart
        humanoidRootPart.CFrame = location.CFrame
    end
end

-- Function to clean up custom resources
local function cleanup()
    autoFarmingEnabled = false

    -- Remove custom GUI elements
    for _, gui in ipairs(customGUIs) do
        if gui and gui.Parent then
            gui:Destroy()
        end
    end
    customGUIs = {}

    -- Stop and remove custom sounds
    for _, sound in ipairs(customSounds) do
        if sound and sound.Parent then
            sound:Stop()
            sound:Destroy()
        end
    end
    customSounds = {}
end

-- Add functions to enable farming
return {
    enableFarming = function()
        autoFarmingEnabled = true
        createAndShowGUI()
        playSound()
        selectAndSpawnCharacter()
    end,

    disableFarming = function()
        cleanup()
    end,

    teleportToPowerstone = function()
        local powerStone = game.Workspace:FindFirstChild("PowerStone")
        if powerStone then
            teleportToLocation(powerStone)
        else
            warn("PowerStone not found in the workspace.")
        end
    end
}
