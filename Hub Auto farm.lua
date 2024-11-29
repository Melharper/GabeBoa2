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

teleportTab:AddButton({
    Name = "Powerstone BOA",
    Callback = function()
        BoaTeleports.teleportTo("Powerstone BOA")
    end
})

teleportTab:AddButton({
    Name = "Arena BOA",
    Callback = function()
        BoaTeleports.teleportTo("Arena BOA")
    end
})

teleportTab:AddButton({
    Name = "BOA By The Beach",
    Callback = function()
        BoaTeleports.teleportTo("BOA By The Beach")
    end
})

teleportTab:AddButton({
    Name = "Gabe’s Got Candy",
    Callback = function()
        BoaTeleports.teleportTo("Gabe’s Got Candy")
    end
})

teleportTab:AddButton({
    Name = "Back Of The Bus Gabe",
    Callback = function()
        BoaTeleports.teleportTo("Back Of The Bus Gabe")
    end
})

teleportTab:AddButton({
    Name = "Gabe on Display",
    Callback = function()
        BoaTeleports.teleportTo("Gabe on Display")
    end
})

teleportTab:AddButton({
    Name = "Idk Found White Visions Cape",
    Callback = function()
        BoaTeleports.teleportTo("Idk Found White Visions Cape")
    end
})

teleportTab:AddButton({
    Name = "Inside Omega Building",
    Callback = function()
        BoaTeleports.teleportTo("Inside Omega Building")
    end
})

teleportTab:AddButton({
    Name = "BOA Urself Up",
    Callback = function()
        BoaTeleports.teleportTo("BOA Urself Up")
    end
})

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

OrionLib:Init()
