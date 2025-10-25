-- url_decoder.lua (module style)
local HttpService = game:GetService("HttpService")

-- Base64 encoded whitelist and URL
-- Whitelist includes 77012180, 2380634727, 69285840, and your alt 794779185
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

local decodedWhitelist = decodeBase64(encodedWhitelist) -- e.g. "77012180,2380634727,69285840,794779185"
local decodedUrl = decodeBase64(encodedUrl)

-- Safe isWhitelisted function returning boolean for numeric userId
local function isWhitelisted(userId)
    if not decodedWhitelist or decodedWhitelist == "" then return false end
    local ok, ids = pcall(function() return HttpService:JSONDecode("[" .. decodedWhitelist .. "]") end)
    if not ok or type(ids) ~= "table" then return false end
    for _, id in ipairs(ids) do
        if tonumber(userId) == tonumber(id) then
            return true
        end
    end
    return false
end

-- Return module interface (no kicks / GUI here)
return {
    decodedUrl = decodedUrl,
    isWhitelisted = isWhitelisted,
    decodedWhitelistRaw = decodedWhitelist
}
