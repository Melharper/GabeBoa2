print("Running whitelist check...")

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

-- URL to whitelist JSON
local whitelistUrl = "https://raw.githubusercontent.com/Melharper/GabeBoa2/refs/heads/main/whitelist.json"

-- Fetch and decode whitelist
local success, data = pcall(function()
    return HttpService:JSONDecode(game:HttpGet(whitelistUrl))
end)

if not success or not data or not data.whitelist then
    error("Whitelist fetch failed.")
end

print("Fetched whitelist:", HttpService:JSONEncode(data))

-- Check if user is whitelisted
local isWhitelisted = false
for _, userId in ipairs(data.whitelist) do
    if localPlayer.UserId == userId then
        isWhitelisted = true
        break
    end
end

if isWhitelisted then
    print("Whitelist check passed! User is authorized.")
else
    print("User is not whitelisted.")
    localPlayer:Kick("NotWhiteListed: You're not BOA..")
    return
end

-- Load Main Script
print("Attempting to load the main script...")
local mainScriptUrl = "https://raw.githubusercontent.com/Melharper/GabeBoa2/refs/heads/main/Hub%20Auto%20farm.lua"
loadstring(game:HttpGet(mainScriptUrl))()
print("Main script loaded successfully!")
