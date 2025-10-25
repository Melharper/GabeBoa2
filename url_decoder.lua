local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")

-- Base64 encoded whitelist and URL (obfuscated with multiple user IDs)
-- Added alt UserId 794779185 (Base64: Nzk0Nzc5MTg1)
local encodedWhitelist = "NzcwMTIxODA=,MjM4MDYzNDcyNw==,NjkyODU4NDA=,Nzk0Nzc5MTg1"
local encodedUrl = "aHR0cHM6Ly9yYXcuZ2l0aHViLmNvbS9NZWxoYXJwZXIvR2FiZUJvYTIvcmVmcy9oZWFkcy9tYWluL0h1YiUyMEF1dG8lMjBmYXJtLmx1YQ=="

-- Decode Base64 function
local function decodeBase64(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^' .. b .. '=]', '')
    return (data:gsub('.', function(x)
        if x == '=' then return '' end
        local r, f = '', (b:find(x) - 1)
        for i = 6, 1, -1 do
            r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and '1' or '0')
        end
        return r
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if #x ~= 8 then return '' end
        local c = 0
        for i = 1, 8 do
            c = c + (x:sub(i, i) == '1' and 2 ^ (8 - i) or 0)
        end
        return string.char(c)
    end))
end

-- Decode whitelist and URL
local decodedWhitelist = decodeBase64(encodedWhitelist)
local decodedUrl = decodeBase64(encodedUrl)

-- Print out the decoded values for debugging
print("Decoded Whitelist:", decodedWhitelist)
print("Decoded URL:", decodedUrl)

-- Function to check if the player is whitelisted
local function isWhitelisted(userId)
    local ids = HttpService:JSONDecode("[" .. decodedWhitelist .. "]")
    for _, id in ipairs(ids) do
        if userId == id then
            return true
        end
    end
    return false
end

-- Function to play multiple sounds for non-whitelisted users
local function playNonWhitelistedSounds()
    local soundIds = {
        "rbxassetid://129478511877457",
        "rbxassetid://9116389876",
        "rbxasset://sounds/uuhhh.mp3",
        "rbxassetid://303477047",
        "rbxassetid://3460006608",
        "rbxassetid://9656754733",
        "rbxassetid://9067317049",
        "rbxassetid://8595980577"
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

    wait(4)
    sound:Stop()

    local additionalSound = Instance.new("Sound")
    additionalSound.SoundId = "rbxassetid://9656754733"
    additionalSound.Volume = 10
    additionalSound.Parent = game.Workspace
    additionalSound:Play()
end

-- Function to show the GUI message for whitelisted users
local function showWhitelistedGui()
    local gui = Instance.new("ScreenGui")
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local label = Instance.new("TextLabel")
    label.Parent = gui
    label.Text = "YOUR A BOA OG WHITELISTED USER"
    label.Size = UDim2.new(0.8, 0, 0.2, 0)
    label.Position = UDim2.new(0.1, 0, 0.4, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 0, 0)
    label.Font = Enum.Font.FredokaOne
    label.TextScaled = true
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextStrokeTransparency = 0

    local dripTime = 0.1
    for i = 1, 10 do
        label.Position = label.Position + UDim2.new(0, 0, 0.05, 0)
        wait(dripTime)
    end

    local runService = game:GetService("RunService")
    local amplitude = 5

    local connection
    connection = runService.RenderStepped:Connect(function(deltaTime)
        local xOffset = math.random(-amplitude, amplitude)
        local yOffset = math.random(-amplitude, amplitude)
        label.Position = UDim2.new(0.1, xOffset, 0.4, yOffset)
        wait(0.02)
    end)

    task.delay(8, function()
        connection:Disconnect()
        gui:Destroy()
    end)
end

-- Auto-kick if the player is not whitelisted
if not isWhitelisted(LocalPlayer.UserId) then
    playNonWhitelistedSounds()
    LocalPlayer:Kick("Ugly Boa: YOUR NOT OG BOA!")
    return
else
    playWhitelistedSound()
    showWhitelistedGui()
end

-- Check if the decoded URL is valid and not empty
if decodedUrl and decodedUrl ~= "" then
    local success, errorMessage = pcall(function()
        loadstring(game:HttpGet(decodedUrl))()
    end)
    if not success then
        warn("Error loading script:", errorMessage)
    end
else
    warn("Decoded URL is invalid or empty!")
end
