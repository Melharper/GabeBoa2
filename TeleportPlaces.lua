-- Boa Teleports Script
-- Description: Teleportation functionality to predefined locations.

local BoaTeleports = {}

-- Table of teleport locations
local teleportLocations = {
    ["Powerstone BOA"] = Vector3.new(891.727783203125, 150.69863891601562, 956.6730346679688),
    ["Arena BOA"] = Vector3.new(1007.6874389648438, 382.5484313964844, 767.2255249023438),
    ["BOA By The Beach"] = Vector3.new(2711.3310546875, 109.19770812988281, -956.5808715820312),
    ["Gabe’s Got Candy"] = Vector3.new(2048.26025390625, 108.09971618652344, -898.4105834960938),
    ["Back Of The Bus Gabe"] = Vector3.new(1535.5809326171875, 108.09658813476562, -107.3639907836914),
    ["Gabe on Display"] = Vector3.new(1496.693603515625, 108.12211608886719, -74.29036712646484),
    ["Idk Found White Visions Cape"] = Vector3.new(-86.74132537841797, 352.6211242675781, -87.8761215209961),
    ["Inside Omega Building"] = Vector3.new(2684.5498046875, 106.09970092773438, -14.75610065460205),
    ["BOA Urself Up"] = Vector3.new(2520.518798828125, 112.09800720214844, 319.3023681640625)
}

-- Function to teleport the player
function BoaTeleports.teleportTo(locationName)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    -- Safeguard CoreGui
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, true)

    if teleportLocations[locationName] then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(teleportLocations[locationName])
            print("Teleported to " .. locationName)
        else
            warn("HumanoidRootPart not found. Teleportation failed.")
        end
    else
        warn("Location not found: " .. locationName)
    end
end

return BoaTeleports
