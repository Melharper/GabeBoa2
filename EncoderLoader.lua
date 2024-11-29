-- Secure EncoderLoader Script
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Whitelist
local authorizedUserIds = {77012180, 2380634727}

-- Check Whitelist
local function isWhitelisted(userId)
    for _, id in ipairs(authorizedUserIds) do
        if userId == id then return true end
    end
    return false
end

if not isWhitelisted(LocalPlayer.UserId) then
    warn("Player not whitelisted:", LocalPlayer.UserId)
    LocalPlayer:Kick("Ugly Boa: YOUR NOT OG BOA!")
    return
else
    print("Player is whitelisted:", LocalPlayer.UserId)
end

-- Base64 Decoder
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

-- Encoded URLs
local encodedUrls = {
    "aHR0cHM6Ly9yYXcuZ2l0aHViLmNvbS9NZWxoYXJwZXIvR2FiZUJvYTIvcmVmcy9oZWFkcy9tYWluL0h1YiUyMEF1dG8lMjBmYXJtLmx1YQ=="
}

-- Decode Layers
local function decodeLayers(layers)
    local decoded = Base64Decode(layers[1])
    for i = 2, #layers do
        decoded = Base64Decode(decoded)
        print("Decoded Layer " .. i .. ":", decoded)
    end
    return decoded
end

-- Decode URL
local decodedUrl = decodeLayers(encodedUrls)
print("Final Decoded URL:", decodedUrl)

-- Execute Script
local success, err = pcall(function()
    loadstring(game:HttpGet(decodedUrl))()
end)

if not success then
    warn("Error executing script:", err)
end
