-- State control for enabling/disabling the script
local isGabeBoaEnabled = true

-- Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

-- Function to toggle Gabe Boa's functionality
local function toggleGabeBoa()
    isGabeBoaEnabled = not isGabeBoaEnabled
    print(isGabeBoaEnabled and "[INFO] Gabe Boa Enabled" or "[INFO] Gabe Boa Disabled")
end

-- Create Scarlet Witch-themed GUI with animations
local function createToggleButton()
    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GabeBoaToggleGUI"
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    -- Create the button
    local button = Instance.new("TextButton")
    button.Name = "ToggleGabeBoaButton"
    button.Text = "Disable Gabe Boa"
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Position = UDim2.new(1, -220, 0.5, -25)
    button.BackgroundColor3 = Color3.fromRGB(128, 0, 0) -- Scarlet red
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Fantasy
    button.TextSize = 18
    button.Parent = screenGui

    -- Add glowing animation
    local uiGradient = Instance.new("UIGradient")
    uiGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 0, 64))
    })
    uiGradient.Parent = button

    -- Draggable functionality
    local dragging = false
    local dragInput, dragStart, startPos

    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = button.Position
        end
    end)

    button.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    button.MouseButton1Click:Connect(function()
        toggleGabeBoa()
        button.Text = isGabeBoaEnabled and "Disable Gabe Boa" or "Enable Gabe Boa"
        button.BackgroundColor3 = isGabeBoaEnabled and Color3.fromRGB(128, 0, 0) or Color3.fromRGB(64, 0, 0)
    end)
end

-- Display "Gabe is So BOAAA" on screen
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

    local fadeOut = TweenService:Create(textLabel, TweenInfo.new(2), { TextTransparency = 1 })
    fadeOut:Play()
    fadeOut.Completed:Connect(function()
        screenGui:Destroy()
    end)
end

-- Function to play background music
local music
local function playMusic()
    music = Instance.new("Sound")
    music.SoundId = "rbxassetid://2820356263" -- Replace with your music ID
    music.Looped = true
    music.Volume = 5
    music.Parent = Workspace
    if isGabeBoaEnabled then
        music:Play()
    end
end

-- Function to respawn character
local function spawnCharacter()
    local args = {
        [1] = "RequestCharacter",
        [2] = "InvisibleWoman", -- Replace with your desired character
        [3] = "Default"
    }
    ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("Network"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
end

-- Monitor for respawn
LocalPlayer.CharacterAdded:Connect(function()
    print("[INFO] Character respawned.")
    if isGabeBoaEnabled then
        spawnCharacter()
    end
end)

-- Main farming loop
spawn(function()
    while true do
        if isGabeBoaEnabled then
            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                spawnCharacter()
                wait(5) -- Allow time for respawn
            end

            local chest = Workspace:FindFirstChild("Chest")
            if chest and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = chest.Body.CFrame
                print("[INFO] Teleported to chest.")
                wait(1)
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, nil)
                wait(5)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, nil)
                print("[INFO] Interacted with chest.")
            else
                print("[INFO] Chest not found.")
            end
        end
        wait(1)
    end
end)

-- Initialize
createToggleButton()
displayGabeBoaText()
playMusic()
spawnCharacter()
