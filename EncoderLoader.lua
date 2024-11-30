-- Ultra-Secure EncoderLoader Script with Sound Effects and Whitelist Obfuscation
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")

-- Whitelist of authorized User IDs (obfuscated using Base64)
local encodedWhitelistedIds = "NzcwMTIxODAsMjM4MDYzNDcyNw==" -- Base64 encoded version of {77012180, 2380634727}

-- Function to decode and check whitelist
local function isWhitelisted(userId)
    local decodedIds = HttpService:Base64Decode(encodedWhitelistedIds)
    local ids = HttpService:JSONDecode("[" .. decodedIds .. "]")  -- Decode the Base64 string into JSON format

    for _, id in ipairs(ids) do
        if userId == id then
            return true
        end
    end
    return false
end

-- Function to play the non-whitelisted sound
local function playNonWhitelistedSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://129478511877457"
    sound.Volume = 10
    sound.Parent = game.Workspace
    sound:Play()
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
end

-- Auto-kick if user is not whitelisted
if not isWhitelisted(LocalPlayer.UserId) then
    -- Play the non-whitelisted sound and kick the player
    playNonWhitelistedSound()
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
    label.TextColor3 = Color3.fromRGB(255, 0, 255)  -- Purple color
    label.Font = Enum.Font.FredokaOne
    label.TextScaled = true
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextStrokeTransparency = 0

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

    -- Stop shaking after 3 seconds
    task.delay(3, function()
        connection:Disconnect()
        gui:Destroy()
    end)
end

-- Base64 Encoded Script URL (Change this URL as needed)
local encodedUrl = "aHR0cHM6Ly9yYXcuZ2l0aHViLmNvbS9NZWxoYXJwZXIvR2FiZUJvYTIvcmVmcy9oZWFkcy9tYWluL0h1YiUyMEF1dG8lMjBmYXJtLmx1YQ=="

-- Base64 Decoder
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

-- Decode the Script URL
local decodedUrl = decodeBase64(encodedUrl)
print("Decoded URL:", decodedUrl) -- Debugging: Print the decoded URL.

-- Load and Execute the Script
local success, err = pcall(function()
    loadstring(game:HttpGet(decodedUrl))()
end)

if not success then
    warn("Error executing script:", err) -- Debugging: Log any execution errors.
end
