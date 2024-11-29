-- Encoded Loader Script
local HttpService = game:GetService("HttpService")

-- Base64-encoded URL for the actual script
local encodedUrl = "aHR0cHM6Ly9yYXcuZ2l0aHViLmNvbS9NZWxoYXJwZXIvR2FiZUJvYTIvcmVmcy9oZWFkcy9tYWluL0h1YiUyMEF1dG8lMjBmYXJtLmx1YQ=="

-- Decode the Base64-encoded URL
local decodedUrl = game:GetService("HttpService"):Base64Decode(encodedUrl)

-- Fetch and execute the script from the decoded URL
local success, err = pcall(function()
    loadstring(game:HttpGet(decodedUrl))()
end)

-- Error handling (optional)
if not success then
    warn("Error executing script: " .. tostring(err))
end
