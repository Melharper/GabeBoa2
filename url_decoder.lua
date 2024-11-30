local HttpService = game:GetService("HttpService")

-- Base64-encoded whitelist and URL
local encodedWhitelist = "NzcwMTIxODA="  -- Base64 encoded version of {77012180}
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

-- Convert the decodedWhitelist string into a table (assuming it's just a single ID in your case)
local whitelistTable = HttpService:JSONDecode("[" .. decodedWhitelist .. "]")

-- Function to check if the player is whitelisted
local function isWhitelisted(userId)
    for _, id in ipairs(whitelistTable) do
        if userId == id then
            return true
        end
    end
    return false
end

-- Return the decoded URL and the whitelist check function
return {
    decodedUrl = decodedUrl,
    isWhitelisted = isWhitelisted
}
