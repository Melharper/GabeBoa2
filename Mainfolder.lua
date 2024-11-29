-- Whitelist Check Loader Script
print("Starting whitelist check...")

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Whitelist URL
local whitelistUrl = "https://raw.githubusercontent.com/Melharper/GabeBoa2/refs/heads/main/whitelist.json"

-- Fetch whitelist
local success, response = pcall(function()
    return game:HttpGet(whitelistUrl)
end)

if not success then
    error("Failed to fetch whitelist. Error: " .. tostring(response))
end

print("Whitelist data fetched:", response)

-- Decode whitelist
local whitelistData
success, whitelistData = pcall(function()
    return HttpService:JSONDecode(response)
end)

if not success or not whitelistData or not whitelistData.whitelist then
    error("Failed to decode whitelist.")
end

print("Decoded whitelist:", HttpService:JSONEncode(whitelistData))

-- Check if user is whitelisted
local isWhitelisted = false
for _, userId in ipairs(whitelistData.whitelist) do
    if LocalPlayer.UserId == userId then
        isWhitelisted = true
        break
    end
end

if not isWhitelisted then
    LocalPlayer:Kick("NotWhiteListed: You're not BOA..")
    return
end

print("User is whitelisted. Loading main script...")

-- Load Main Script
local mainScriptUrl = "https://raw.githubusercontent.com/Melharper/GabeBoa2/refs/heads/main/Hub%20Auto%20farm.lua"
local mainScriptSuccess, mainScriptError = pcall(function()
    loadstring(game:HttpGet(mainScriptUrl))()
end)

if not mainScriptSuccess then
    error("Failed to load main script. Error: " .. tostring(mainScriptError))
end

print("Main script loaded successfully.")
