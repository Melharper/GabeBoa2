-- OrionLib Integration for Gabe Boa Auto-Farming
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Gabe Boa Farming", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionConfig"})
local Tab = Window:MakeTab({Name = "Auto-Farming", Icon = "rbxassetid://4483345998", PremiumOnly = false})

local gabeBoa = loadstring(game:HttpGet("https://raw.githubusercontent.com/Melharper/GabeBoa2/refs/heads/main/GabeBOA2.lua"))()

Tab:AddToggle({
    Name = "Enable Auto-Farming",
    Default = false,
    Callback = function(value)
        if value then
            gabeBoa.enableFarming()
        else
            gabeBoa.disableFarming()
        end
    end
})

OrionLib:Init()
