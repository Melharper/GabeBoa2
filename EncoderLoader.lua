-- Fetch the URL decoder script securely (hidden logic)
local urlDecoderScript = game:HttpGet("https://raw.githubusercontent.com/Melharper/GabeBoa2/refs/heads/main/url_decoder.lua")
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
