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

-- Function to create Scarlet Witch-themed GUI button with animations
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
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Position = UDim2.new(1, -220, 0.5, -25)
    button.BackgroundColor3 = Color3.fromRGB(128, 0, 0) -- Scarlet red
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Fantasy
    button.TextSize = 18
    button.Parent = screenGui

    -- Add animations to the button
    local uiGradient = Instance.new("UIGradient")
    uiGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 128, 128))
    })
    uiGradient.Parent = button

    -- Toggle functionality when button is clicked
    button.MouseButton1Click:Connect(function()
        toggleGabeBoa()
        button.Text = isGabeBoaEnabled and "Disable Gabe Boa" or "Enable Gabe Boa"
        button.BackgroundColor3 = isGabeBoaEnabled and Color3.fromRGB(128, 0, 0) or Color3.fromRGB(64, 0, 0)
    end)

    -- Add drag functionality
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
end

-- Create the toggle button
createToggleButton()

-- Play "Gabe is So Boa" animation upon execution
local function playGabeBoaAnimation()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://1234567890" -- Replace with "Gabe is so boa" sound asset ID
    sound.Volume = 5
    sound.Parent = game.Workspace
    sound:Play()
end
playGabeBoaAnimation()

-- Function to spawn character
local function spawnCharacter()
    local args = {
        [1] = "RequestCharacter",
        [2] = "InvisibleWoman", -- Replace with your desired character
        [3] = "Default"
    }

    local success, result = pcall(function()
        return game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("Network"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
    end)

    if success then
        print("[INFO] Character spawned successfully!")
    else
        print("[ERROR] Failed to spawn character:", result)
    end
end

-- Automatic respawn function
local function monitorRespawn()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    LocalPlayer.CharacterAdded:Connect(function()
        print("[INFO] Character respawned.")
        if isGabeBoaEnabled then
            spawnCharacter()
        end
    end)
end

monitorRespawn()

-- Main farming loop
spawn(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Workspace = game:GetService("Workspace")
    local VirtualInputManager = game:GetService("VirtualInputManager")

    while true do
        if isGabeBoaEnabled then
            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                print("[INFO] Character not found. Respawning...")
                spawnCharacter()
                LocalPlayer.CharacterAdded:Wait()
            end

            local chest = Workspace:FindFirstChild("Chest")
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
            wait(1) -- Small delay when disabled
        end
        wait(1)
    end
end)
