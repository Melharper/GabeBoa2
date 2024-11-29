-- Module for Auto-Farming
local AutoFarm = {}

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

-- Function to set camera position
local function setCameraPosition()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Camera = game.Workspace.CurrentCamera

    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local character = LocalPlayer.Character
        local position = character.HumanoidRootPart.Position + Vector3.new(0, 10, 0)
        local targetPosition = character.HumanoidRootPart.Position
        Camera.CFrame = CFrame.new(position, targetPosition)
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

-- Function to respawn character
local function autoRespawnCharacter()
    game.Players.LocalPlayer.CharacterRemoving:Connect(function()
        if autoFarmingEnabled then
            wait(5)
            selectAndSpawnCharacter()
            setCameraPosition() -- Correct camera after respawn
        end
    end)
end

-- Function to clean up custom resources
function AutoFarm.cleanup()
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

-- Function to start auto-farming
function AutoFarm.start()
    autoFarmingEnabled = true
    createAndShowGUI()
    playSound()
    selectAndSpawnCharacter()
    spawn(farmChests)
    startAntiAfk()
    autoRespawnCharacter()
    setCameraPosition() -- Initial camera correction
end

return AutoFarm
