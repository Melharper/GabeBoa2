-- Ultra-Secure EncoderLoader Script
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Whitelist of authorized User IDs
local authorizedUserIds = {
    77012180,     -- Your User ID
    2380634727    -- Another User ID
}

-- Function to check if a user is whitelisted
local function isWhitelisted(userId)
    for _, id in ipairs(authorizedUserIds) do
        if userId == id then
            return true
        end
    end
    return false
end

-- Auto-kick if user is not whitelisted
if not isWhitelisted(LocalPlayer.UserId) then
    LocalPlayer:Kick("Ugly Boa: YOUR NOT OG BOA!")
    return
end

-- Custom Base64 Decoder
local function Base64Decode(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^' .. b .. '=]', '')
    return (data:gsub('.', function(x)
        if x == '=' then return '' end
        local r, f = '', (b:find(x) - 1)
        for i = 6, 1, -1 do r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and '1' or '0') end
        return r
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if #x ~= 8 then return '' end
        local c = 0
        for i = 1, 8 do c = c + (x:sub(i, i) == '1' and 2 ^ (8 - i) or 0) end
        return string.char(c)
    end))
end

-- Multi-layered encoded URLs
local encodedUrls = {
    -- 1st Layer
    "WVhWMGNuVnVZMlZ5TFhKbGMyVnllQzl0YldWd...",
    -- 2nd Layer
    "aHR0cHM6Ly9yYXcuZ2l0aHViLmNvbS9NZWxoYX...",
    -- 3rd Layer
    "aHR0cHM6Ly9yYXcuZ2l0aHViLmNvbS9NZWxoYX...",
    -- Add more layers up to 300 lines
}

-- Function to decode all layers
local function decodeLayers(layers)
    local decoded = Base64Decode(layers[1])
    for i = 2, #layers do
        decoded = Base64Decode(decoded)
        assert(decoded == Base64Decode(layers[i]), "Validation failed: URL mismatch in layer " .. i)
    end
    return decoded
end

-- Decoding the final URL
local decodedUrl = decodeLayers(encodedUrls)

-- Additional Hash Validation for Decoded URL
local function validateHash(decodedData)
    local expectedHash = "simulated-hash-placeholder" -- Replace with a proper hash
    local actualHash = HttpService:GenerateGUID(false) -- Simulated hash (replace with MD5/SHA256 for real protection)
    assert(expectedHash == actualHash, "Hash mismatch detected! Script execution halted.")
end

validateHash(decodedUrl)

-- Environment Validation
local function validateEnvironment()
    assert(game and game:GetService("HttpService"), "Environment validation failed.")
    assert(HttpService:JSONDecode("[]"), "Environment validation failed: JSONDecode malfunctioning.")
end

validateEnvironment()

-- Safeguard: Disable Developer Console
pcall(function()
    game:GetService("StarterGui"):SetCore("DevConsoleVisible", false)
end)

-- Final Script Execution
local success, err = pcall(function()
    loadstring(game:HttpGet(decodedUrl))()
end)

if not success then
    warn("Execution failed: " .. tostring(err))
    error("Script execution aborted.")
end
