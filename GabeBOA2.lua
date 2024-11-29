-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- State Control
local isGabeBoaEnabled = true
local music
local chestCooldown = false -- Prevent interaction spamming

-- Toggle Gabe Boa's functionality
local function toggleGabeBoa()
    isGabeBoaEnabled = not isGabeBoaEnabled
    print(isGabeBoaEnabled and "[INFO] Gabe Boa Enabled" or "[INFO] Gabe Boa Disabled")
    if music then
        if isGabeBoaEnabled then
            music:Play()
        else
            music:Stop()
        end
    end
end

-- Scarlet Witch-themed GUI
local function createToggleButton()
    if LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("GabeBoaToggleGUI") then
        return
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GabeBoaToggleGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local button = Instance.new("TextButton")
    button.Name = "ToggleGabeBoaButton"
    button.Text = "Disable Gabe Boa"
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Position = UDim2.new(1, -220, 0.5, -25)
    button.BackgroundColor3 = Color3.fromRGB(128, 0, 0)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Fantasy
    button.TextSize = 18
    button.Parent = screenGui

    -- Toggle Functionality
    button.MouseButton1Click:Connect(function()
        toggleGabeBoa()
        button.Text = isGabeBoaEnabled and "Disable Gabe Boa" or "Enable Gabe Boa"
        button.BackgroundColor3 = isGabeBoaEnabled and Color3.fromRGB(128, 0, 0) or Color3.fromRGB(64, 0, 0)
    end)
end

-- Display "Gabe is So BOAAA" Animation
local function displayGabeBoaText()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GabeBoaTextGUI"
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local textLabel = Instance.new("TextLabel")
    textLabel.Text = "GABE IS SO BOAAA"
    textLabel.Font = Enum.Font.Arcade
    textLabel.TextSize = 50
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.fromRGB(128, 0, 0)
    textLabel.Parent = screenGui

    game:GetService("TweenService"):Create(
        textLabel,
        TweenInfo.new(2),
        { TextTransparency = 1 }
    ):Play()
    wait(2)
    screenGui:Destroy()
end

-- Background Music
local function playMusic()
    music = Instance.new("Sound")
    music.SoundId = "rbxassetid://2820356263"
    music.Looped = true
    music.Volume = 5
    music.Parent = Workspace
    if isGabeBoaEnabled then
        music:Play()
    end
end

-- Adjust Camera
local function adjustCamera()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 10, 0)
        local targetPosition = LocalPlayer.Character.HumanoidRootPart.Position
        Camera.CFrame = CFrame.new(position, targetPosition)
        Camera.FieldOfView = 70
        Camera.CameraType = Enum.CameraType.Custom
        print("[INFO] Camera adjusted.")
    end
end

-- Spawn Character
local function spawnCharacter()
    local args = {
        [1] = "RequestCharacter",
        [2] = "InvisibleWoman", -- Replace with your desired character
        [3] = "Default"
    }
    ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("Network"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
    print("[INFO] Character spawned.")
end

-- Respawn Character and Adjust Camera
LocalPlayer.CharacterAdded:Connect(function()
    print("[INFO] Character respawned.")
    if isGabeBoaEnabled then
        wait(1) -- Ensure character fully loads
        adjustCamera() -- Adjust camera after respawn
    end
end)

LocalPlayer.CharacterRemoving:Connect(function()
    print("[INFO] Character died. Respawning...")
    if isGabeBoaEnabled then
        wait(5) -- Wait for respawn process
        spawnCharacter()
    end
end)

-- Chest Farming Functionality
spawn(function()
    while true do
        if isGabeBoaEnabled and not chestCooldown and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local chest = Workspace:FindFirstChild("Chest")
            if chest then
                chestCooldown = true
                -- Teleport to chest
                LocalPlayer.Character.HumanoidRootPart.CFrame = chest.Body.CFrame
                print("[INFO] Teleported to chest.")
                adjustCamera() -- Adjust camera after teleport
                wait(1)
                -- Interact with chest
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, nil)
                wait(3) -- Give time for interaction
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, nil)
                print("[INFO] Interacted with chest.")
                wait(5) -- Cooldown before next interaction
                chestCooldown = false
            else
                print("[INFO] Chest not found. Waiting...")
            end
        end
        wait(1)
    end
end)

-- Execution
createToggleButton()
displayGabeBoaText()
playMusic()
spawnCharacter()
