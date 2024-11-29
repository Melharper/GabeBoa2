-- Encoded Loader Script
local HttpService = game:GetService("HttpService")
local encodedUrl = "aHR0cHM6Ly9yYXcuZ2l0aHViLmNvbS9NZWxoYXJwZXIvR2FiZUJvYTIvcmVmcy9oZWFkcy9tYWluL0h1YiUyMEF1dG8lMjBmYXJtLmx1YQ==" -- Encoded URL

local decodedUrl = HttpService:Base64Decode(encodedUrl) -- Decodes URL
loadstring(game:HttpGet(decodedUrl))() -- Executes the decoded script
