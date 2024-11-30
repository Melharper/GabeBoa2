local HttpService = game:GetService("HttpService")

-- Break down the URL decoder script URL for better hiding.
local urlPart1 = "h" .. "ttp" .. "s://raw.githubusercontent.com/Melharper/GabeBoa2/refs/heads/main/"
local urlPart2 = "url_decoder.lua"
local fullUrl = urlPart1 .. urlPart2

-- Fetch the URL decoder script securely
local urlDecoderScript
local success, err = pcall(function()
    urlDecoderScript = game:HttpGet(fullUrl)
end)

if not success or not urlDecoderScript or urlDecoderScript == "" then
    warn("Failed to retrieve URL decoder script: " .. (err or "Unknown error"))
    return
end

-- Print first 200 characters of the fetched script for debugging
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
