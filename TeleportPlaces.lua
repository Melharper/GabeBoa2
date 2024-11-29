-- Description: Teleportation functionality to predefined locations.

local BoaTeleports = {}

-- Table of teleport locations (corrected format)
local teleportLocations = {
    ["Powerstone BOA"] = Vector3.new(891.727783, 150.698639, 956.673035),
    ["Arena BOA"] = Vector3.new(1007.687439, 382.548431, 767.225525),
    ["BOA By The Beach"] = Vector3.new(2711.331055, 109.197708, -956.580872),
    ["Gabe’s Got Candy"] = Vector3.new(2048.260254, 108.099716, -898.410584),
    ["Back Of The Bus Gabe"] = Vector3.new(1535.580933, 108.096588, -107.363991),
    ["Gabe on Display"] = Vector3.new(1496.693604, 108.122116, -74.290367),
    ["Idk Found White Visions Cape"] = Vector3.new(-86.741325, 352.621124, -87.876122),
    ["Inside Omega Building"] = Vector3.new(2684.549805, 106.099701, -14.756101),
    ["BOA Urself Up"] = Vector3.new(2520.518799, 112.098007, 319.302368),
    ["Gabe&Snicks XXX spot"] = Vector3.new(2199.461426, 108.099716, -898.677795) -- Added new location
}

-- Function to teleport the player
function BoaTeleports.teleportTo(locationName)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    -- Check if the location exists
    if teleportLocations[locationName] then
        -- Ensure the player's character and HumanoidRootPart exist
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            -- Teleport the player to the specified location
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
