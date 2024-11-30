-- Break the URL into smaller pieces
local part1 = "https" 
local part2 = "://raw" 
local part3 = ".github" 
local part4 = ".com/Melharper" 
local part5 = "/GabeBoa2" 
local part6 = "/refs/heads/main/EncoderLoader.lua"

-- Combine the parts to form the full URL
local fullUrl = part1 .. part2 .. part3 .. part4 .. part5 .. part6

-- Fetch the URL decoder script
local urlDecoderScript
local success, err = pcall(function()
    urlDecoderScript = game:HttpGet(fullUrl)
end)

if not success or not urlDecoderScript or urlDecoderScript == "" then
    warn("Failed to retrieve URL decoder script: " .. (err or "Unknown error"))
    return
end

-- Print the first 200 characters of the fetched script for debugging
print("Fetched script (first 200 characters):", string.sub(urlDecoderScript, 1, 200))

-- Execute the URL decoder script to get the URL and whitelist function
local urlDecoder, executionErr = pcall(loadstring(urlDecoderScript))

if not urlDecoder then
    warn("Error executing URL decoder script:", executionErr)
    return
end

-- Access the decoded URL and whitelist check function
local decodedUrl = urlDecoder.decodedUrl
local isWhitelisted = urlDecoder.isWhitelisted

if not decodedUrl or decodedUrl == "" then
    warn("Decoded URL is invalid or empty!")
    return
end

-- Check if the decoded URL is valid and not empty
local successLoad, loadErrorMessage = pcall(function()
    -- Load and execute the decoded URL (Orion Hub / Hub Auto Farming script)
    loadstring(game:HttpGet(decodedUrl))()
end)

if not successLoad then
    warn("Error loading the script:", loadErrorMessage)
end
