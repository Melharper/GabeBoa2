-- State control for enabling/disabling the script
local isGabeBoaEnabled = true

-- Function to toggle Gabe Boa's functionality
local function toggleGabeBoa()
    isGabeBoaEnabled = not isGabeBoaEnabled
    if isGabeBoaEnabled then
        print("[INFO] Gabe Boa Enabled")
    else
        print("[INFO] Gabe Boa Disabled")
    end
end

-- Function to create a draggable GUI button
local function createToggleButton()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GabeBoaToggleGUI"
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    -- Create the button
    local button = Instance.new("TextButton")
    button.Name = "ToggleGabeBoaButton"
    button.Text = "Disable Gabe Boa"
    button.Size = UDim2.new(0, 200, 0, 50) -- Small button
    button.Position = UDim2.new(1, -220, 0.5, -25) -- Right side of the screen
    button.BackgroundColor3 = Color3.fromRGB(163, 73, 164) -- Wanda Maximoff purple
    button.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
    button.Font = Enum.Font.GothamBold
    button.TextSize = 18
    button.Parent = screenGui

    -- Add drag functionality to the button
    local dragging = false
    local dragInput, dragStart, startPos

    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = button.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    button.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Toggle functionality when button is clicked
    button.MouseButton1Click:Connect(function()
        toggleGabeBoa()
        button.Text = isGabeBoaEnabled and "Disable Gabe Boa" or "Enable Gabe Boa"
        button.BackgroundColor3 = isGabeBoaEnabled and Color3.fromRGB(163, 73, 164) or Color3.fromRGB(128, 0, 0) -- Purple for enabled, dark red for disabled
    end)
end

-- Create the toggle button
createToggleButton()

-- Function to play sound
local function playSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://2820356263" -- Replace with your sound asset ID
    sound.Looped = true
    sound.Volume = 10 -- Adjust volume
    sound.Parent = game.Workspace
    sound:Play()
    return sound
end

-- Start playing music and keep reference
local music = playSound()

-- Anti-idle function to simulate activity
local function antiIdle()
    local VirtualInputManager = game:GetService("VirtualInputManager")
    while true do
        if isGabeBoaEnabled then
            VirtualInputManager:SendMouseMovement(Vector2.new(0, 0), 0.1)
        end
        wait(30) -- Every 30 seconds
    end
end

-- Main loop to teleport and interact with chests
spawn(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Workspace = game:GetService("Workspace")
    local VirtualInputManager = game:GetService("VirtualInputManager")

    while true do
        if isGabeBoaEnabled then
            local chest = Workspace:FindFirstChild("Chest")
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                if chest then
                    -- Teleport to chest
                    LocalPlayer.Character.HumanoidRootPart.CFrame = chest.Body.CFrame
                    print("[INFO] Teleported to chest.")
                    wait(1)
                    -- Interact with chest
                    if (chest.Body.CFrame.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, nil)
                        wait(5)
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, nil)
                        print("[INFO] Interacted with chest.")
                    else
                        print("[INFO] Too far from chest.")
                    end
                else
                    print("[INFO] Chest not found. Waiting for new chest.")
                end
            else
                print("[INFO] Character not found. Waiting for respawn.")
                LocalPlayer.CharacterAdded:Wait()
            end
        else
            -- Stop music and clear messages when disabled
            if music.IsPlaying then
                music:Stop()
            end
        end
        wait(1)
    end
end)

-- Run anti-idle in a separate thread
spawn(antiIdle)
