-- Gabe Boa Auto-Farming Script
-- Description: Auto-farming functionality with GUI, sound effects, camera correction, and auto-respawn.

-- Variables to manage the toggle state
local autoFarmingEnabled = false
local customGUIs = {}
local customSounds = {}

-- Function to create and show GUI
local function createAndShowGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GabeBoaGUI"
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
    sound.Name = "GabeBoaSound"
    sound.SoundId = "rbxassetid://2820356263"
    sound.Parent = game.Workspace
    sound.Looped = true
    sound.Volume = 10
    sound:Play()
    table.insert(customSounds, sound)
end

-- Function to set camera position
local function setCameraPosition()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera

    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local character = LocalPlayer.Character
        local position = character.HumanoidRootPart.Position + Vector3.new(0, 10, 0)
        local targetPosition = character.HumanoidRootPart.Position
        Camera.CFrame = CFrame.new(position, targetPosition)
    end
end

-- Auto-respawn the character after death
local function autoRespawnCharacter()
    -- Monitor when the character is removed
    game.Players.LocalPlayer.CharacterRemoving:Connect(function()
        if autoFarmingEnabled then
            wait(5) -- Delay before attempting to respawn
            selectAndSpawnCharacter() -- Spawn the character
        end
    end)

    -- Restart farming and GUI after respawn
    game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
        if autoFarmingEnabled then
            wait(1) -- Ensure character is fully loaded
            setCameraPosition()
            createAndShowGUI()
            startAntiAfk()
            spawn(farmChests) -- Resume chest farming
        end
    end)
end

-- Function to select and spawn the character
local function selectAndSpawnCharacter()
    local args = {
        [1] = "RequestCharacter",
        [2] = "InvisibleWoman",
        [3] = "Default"
    }

    -- Retry logic in case of failure
    for i = 1, 3 do
        local success = pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("Network"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
        end)

        if success then
            break
        else
            wait(2) -- Retry after a short delay
        end
    end
end

-- Function to teleport to and interact with chests
local function farmChests()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Workspace = game:GetService("Workspace")
    local VirtualInputManager = game:GetService("VirtualInputManager")

    local function teleportToChest()
        local chest = Workspace:FindFirstChild("Chest")
        if chest and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = chest.Body.CFrame
        end
    end

    local function interactWithChest()
        local chest = Workspace:FindFirstChild("Chest")
        if chest and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local chestPos = chest.Body.CFrame.Position
            local playerPos = LocalPlayer.Character.HumanoidRootPart.Position

            if (chestPos - playerPos).Magnitude <= 10 then
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, nil)
                wait(5)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, nil)
            end
        end
    end

    while autoFarmingEnabled do
        local chest = Workspace:FindFirstChild("Chest")
        if chest then
            teleportToChest()
            wait(1)
            interactWithChest()
        end
        wait(1)
    end
end

-- Function to prevent AFK
local function startAntiAfk()
    spawn(function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        while autoFarmingEnabled do
            if LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:Move(Vector3.new(0.1, 0, 0))
                end
            end
            wait(60)
        end
    end)
end

-- Function to clean up custom resources
local function cleanup()
    autoFarmingEnabled = false

    for _, gui in ipairs(customGUIs) do
        if gui and gui.Parent then
            gui:Destroy()
        end
    end
    customGUIs = {}

    for _, sound in ipairs(customSounds) do
        if sound and sound.Parent then
            sound:Stop()
            sound:Destroy()
        end
    end
    customSounds = {}
end

-- Ensure Core GUI is not disabled
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, true)

-- Public interface for enabling/disabling farming
return {
    enableFarming = function()
        autoFarmingEnabled = true
        createAndShowGUI()
        playSound()
        selectAndSpawnCharacter()
        setCameraPosition() -- Initial camera correction
        autoRespawnCharacter() -- Ensure auto-respawn is active
        spawn(farmChests)
        startAntiAfk()
    end,

    disableFarming = function()
        cleanup()
    end
}
