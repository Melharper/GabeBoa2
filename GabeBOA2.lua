local correctPassword = "WatchingGabe"
local userInputPassword = ""  -- Store the user's input here
local passwordEntered = false  -- Flag to check if the password has been entered successfully

-- Function to prompt the user for password input (only once)
local function promptForPassword()
    if passwordEntered then return end  -- If the password was already entered, don't ask again.

    local GuiService = game:GetService("GuiService")
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local inputBox = Instance.new("TextBox")
    inputBox.Size = UDim2.new(0, 400, 0, 50)
    inputBox.Position = UDim2.new(0.5, -200, 0.5, -25)
    inputBox.PlaceholderText = "Enter Password"
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.BackgroundTransparency = 0.5
    inputBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    inputBox.ClearTextOnFocus = true
    inputBox.Parent = screenGui

    -- Wait for the player to input a password and press Enter
    inputBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            userInputPassword = inputBox.Text
            screenGui:Destroy()  -- Remove the password input UI

            if userInputPassword == correctPassword then
                passwordEntered = true
                print("[INFO] Password correct, script will now execute.")
                executeMainScript()  -- Call the function that runs your main script
            else
                print("[ERROR] Incorrect password.")
                game.Players.LocalPlayer:Kick("Incorrect password, try again.")
            end
        end
    end)

    -- Prevent the player from continuing until they enter the correct password
    GuiService:SetCore("TopbarEnabled", false)  -- Disable top bar temporarily
end

-- Function to run the main script after successful password validation
local function executeMainScript()
    -- Function to create and show the GUI with text
    local function createAndShowGUI()
        local screenGui = Instance.new("ScreenGui")
        screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        print("ScreenGui Created")

        for i = 0, 10 do  -- Repeat 10 times
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
            print("TextLabel Created")
        end

        wait(3)
        screenGui:Destroy()
        print("ScreenGui Destroyed")
    end

    -- Create the GUI when the script is executed
    createAndShowGUI()

    -- Function to play the sound at regular intervals
    local function playSoundContinuously()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://2820356263"
        sound.Parent = game.Workspace
        sound.Looped = true
        sound.Volume = 10
        sound:Play()

        while true do
            if not sound.IsPlaying then
                sound:Play()
            end
            wait(5)
        end
    end

    -- Call the sound-playing function
    spawn(playSoundContinuously)

    -- Function to select and spawn Invisible Woman character (only once)
    local function selectAndSpawnCharacter()
        print("[INFO] Attempting to select and spawn Invisible Woman...")

        local args = {
            [1] = "RequestCharacter",
            [2] = "InvisibleWoman",
            [3] = "Default"
        }

        local success, result = pcall(function()
            return game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("Network"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
        end)

        if success then
            print("[INFO] Invisible Woman character selected and deployed!")
        else
            print("[ERROR] Failed to select character: " .. tostring(result))
        end
    end

    wait(5)

    -- Ensure the character is spawned only once
    selectAndSpawnCharacter()

    -- Position camera and interact with the chest as before
    setCameraPosition()
    teleportToChest()
    interactWithChest()
end

-- Initialize the password input process
promptForPassword()
