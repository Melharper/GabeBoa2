-- Encoded Loader Script
local HttpService = game:GetService("HttpService")

-- Obfuscated and jumbled URL logic
local parts = {
    "https://raw.", "githubuser", "content.com/", "Melhar", "per/Gab",
    "eBoa2/re", "fs/hea", "ds/main/", "Hub%20", "Auto%20", "farm.", "lua"
}

local url = table.concat(parts) -- Combine all parts into the URL

-- Fetch and execute the script from the obfuscated URL
local success, err = pcall(function()
    loadstring(game:HttpGet(url))()
end)

-- Error handling (optional)
if not success then
    warn("Error executing script: " .. tostring(err))
end
