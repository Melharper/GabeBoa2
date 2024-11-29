-- Whitelist Check Loader Script
local a = game:GetService
local b = a("HttpService")
local c = a("Players")
local d = c.LocalPlayer
local e = "aHR0cHM6Ly9yYXcuZ2l0aHViLmNvbS9NZWxoYXJwZXIvR2FiZUJvYTIvcmVmcy9oZWFkcy9tYWluL3doaXRlbGlzdC5qc29u"

local function f(g)
    local h = ""
    for i = 1, #g, 2 do
        h = h .. string.char(tonumber(g:sub(i, i + 1), 16))
    end
    return h
end

e = f(e)

local success, data = pcall(function()
    return b:JSONDecode(game:HttpGet(e))
end)

if not success or not data or not data.whitelist then
    error("Whitelist failed.")
end

local isWhitelisted = false
for _, userId in ipairs(data.whitelist) do
    if d.UserId == userId then
        isWhitelisted = true
        break
    end
end

if not isWhitelisted then
    d:Kick("NotWhiteListed: You're not BOA..")
    return
end

-- Load Main Script
local mainScriptUrl = "https://raw.githubusercontent.com/Melharper/GabeBoa2/refs/heads/main/Hub%20Auto%20farm.lua"
loadstring(game:HttpGet(mainScriptUrl))()
