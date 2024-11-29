print("Running whitelist check...")

local e = "https://raw.githubusercontent.com/Melharper/GabeBoa2/refs/heads/main/whitelist.json"
local b = game:GetService("HttpService")
local c = game:GetService("Players").LocalPlayer
local success, data = pcall(function()
    return b:JSONDecode(game:HttpGet(e))
end)

if not success then
    error("Whitelist fetch failed.")
end

print("Fetched whitelist:", b:JSONEncode(data))

local isWhitelisted = false
for _, userId in ipairs(data.whitelist) do
    if c.UserId == userId then
        isWhitelisted = true
        break
    end
end

if isWhitelisted then
    print("User is whitelisted!")
else
    print("User is not whitelisted.")
    c:Kick("NotWhiteListed: You're not BOA..")
end
