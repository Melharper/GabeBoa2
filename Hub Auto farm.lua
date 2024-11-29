-- OrionLib Integration for Gabe&Snicks BOA Cult
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "Gabe&Snicks BOA Cult",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "OrionConfig"
})

-- Load Scripts
local gabeBoa = loadstring(game:HttpGet("https://raw.githubusercontent.com/Melharper/GabeBoa2/refs/heads/main/GabeBOA2.lua"))()
local BoaTeleports = loadstring(game:HttpGet("https://raw.githubusercontent.com/Melharper/GabeBoa2/refs/heads/main/TeleportPlaces.lua"))()
local InfiniteYield = loadstring(game:HttpGet("https://raw.githubusercontent.com/Melharper/GabeBoa2/refs/heads/main/InfiniteYield.lua"))()
local Powers = loadstring(game:HttpGet("https://raw.githubusercontent.com/Melharper/GabeBoa2/refs/heads/main/Powers.lua"))()

-- Auto-Farming Tab
local farmingTab = Window:MakeTab({
    Name = "Gabe Boa Farming",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

farmingTab:AddToggle({
    Name = "Enable Auto-BOA Farming",
    Default = false,
    Callback = function(value)
        if value then
            gabeBoa.enableFarming()
        else
            gabeBoa.disableFarming()
        end
    end
})

-- Boa Teleports Tab
local teleportTab = Window:MakeTab({
    Name = "Boa Teleports",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local teleportLocations = {
    "Powerstone BOA",
    "Arena BOA",
    "BOA By The Beach",
    "Gabe’s Got Candy",
    "Back Of The Bus Gabe",
    "Gabe on Display",
    "Idk Found White Visions Cape",
    "Inside Omega Building",
    "BOA Urself Up",
    "Gabe&Snicks XXX spot"
}

for _, location in ipairs(teleportLocations) do
    teleportTab:AddButton({
        Name = location,
        Callback = function()
            BoaTeleports.teleportTo(location)
        end
    })
end

-- Powers Tab
local powersTab = Window:MakeTab({
    Name = "Powers",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

powersTab:AddButton({
    Name = "Woman's Mace",
    Callback = function()
        Powers.womansMace()
    end
})

-- Infinite Yield Tab
local adminTab = Window:MakeTab({
    Name = "Infinite Yield",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

adminTab:AddButton({
    Name = "BOA Admin",
    Callback = function()
        InfiniteYield.load()
    end
})

-- Initialize OrionLib
OrionLib:Init()
