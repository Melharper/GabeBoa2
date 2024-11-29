-- Powers Script
-- Description: Custom powers/actions for the Powers toggle.

local Powers = {}

-- Woman's Mace Ability
function Powers.womansMace()
    -- Define the remote
    local remote = game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("Network"):WaitForChild("RemoteFunction")
    
    -- Fire the remote with the ability name
    local success, err = pcall(function()
        remote:InvokeServer("Raptor") -- Replace "Raptor" if the ability name changes
    end)
    
    if success then
        print("Woman's Mace activated!")
    else
        warn("Failed to activate Woman's Mace: " .. tostring(err))
    end
end

return Powers
