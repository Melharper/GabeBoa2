-- Debug-Friendly Encoded Loader Script
local HttpService = game:GetService("HttpService")

-- Obfuscated URL as parts
local parts = {
    "https://raw.", 
    "githubuser", 
    "content.com/", 
    "Melhar", 
    "per/Gab", 
    "eBoa2/re", 
    "fs/hea", 
    "ds/main/", 
    "Hub%20", 
    "Auto%20", 
    "farm.", 
    "lua"
}

-- Combine the URL parts
local url = table.concat(parts)

-- Debug output to verify URL
print("Decoded URL: " .. url)

-- Attempt to fetch and execute the script
local success, err = pcall(function()
    loadstring(game:HttpGet(url))()
end)

-- Debugging for errors
if not success then
    warn("Error executing script: " .. tostring(err))
end
