local TeleportPlaces = {}

function TeleportPlaces.teleportTo(locationName)
    local locations = {
        ["Powerstone BOA"] = Vector3.new(100, 50, -200),
        ["Arena BOA"] = Vector3.new(300, 75, -500),
        ["BOA By The Beach"] = Vector3.new(600, 10, -700),
        ["Gabe’s Got Candy"] = Vector3.new(400, 20, -100),
        ["Back Of The Bus Gabe"] = Vector3.new(500, 15, -300),
        ["Gabe on Display"] = Vector3.new(250, 35, -450),
        ["Idk Found White Visions Cape"] = Vector3.new(800, 60, -600),
        ["Inside Omega Building"] = Vector3.new(900, 45, -1000),
        ["BOA Urself Up"] = Vector3.new(700, 25, -850),
        ["Gabe&Snicks XXX spot"] = Vector3.new(2199.461426, 108.099716, -898.677795)
    }

    if locations[locationName] then
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        humanoidRootPart.CFrame = CFrame.new(locations[locationName])
    else
        warn("Location not found: " .. locationName)
    end
end

return TeleportPlaces
