-- Ultra-Secure EncoderLoader Script with GUI Effects
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")

-- Whitelist of Authorized User IDs
local authorizedUserIds = {77012180, 2380634727}

-- Function to Check Whitelist
local function isWhitelisted(userId)
    for _, id in ipairs(authorizedUserIds) do
        if userId == id then
            return true
        end
    end
    return false
end

-- Function to Create a Shaking Message
local function displayShakingMessage(message)
    local gui = Instance.new("ScreenGui")
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local label = Instance.new("TextLabel")
    label.Parent = gui
    label.Text = message
    label.Size = UDim2.new(0.8, 0, 0.2, 0)
    label.Position = UDim2.new(0.1, 0, 0.4, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 0, 255)
    label.Font = Enum.Font.FredokaOne -- Use a suitable font
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

-- Check Whitelist and Display Message
if isWhitelisted(LocalPlayer.UserId) then
    print("Player is whitelisted:", LocalPlayer.UserId)
    displayShakingMessage("YOUR A BOA OG WHITELISTED USER")
else
    warn("Player not whitelisted:", LocalPlayer.UserId)
    LocalPlayer:Kick("Ugly Boa: YOUR NOT OG BOA!")
    return
end

-- Base64 Encoded Script URL
local encodedUrl = "aHR0cHM6Ly9yYXcuZ2l0aHViLmNvbS9NZWxoYXJwZXIvR2FiZUJvYTIvcmVmcy9oZWFkcy9tYWluL0h1YiUyMEF1dG8lMjBmYXJtLmx1YQ==" -- Replace this with your Base64-encoded URL.

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
