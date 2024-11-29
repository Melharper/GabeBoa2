-- Infinite Yield Script
-- Description: Functionality to load Infinite Yield admin commands.

local InfiniteYield = {}

-- Ensure CoreGui is enabled
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)

-- Function to load Infinite Yield
function InfiniteYield.load()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end)
    if success then
        print("Infinite Yield loaded successfully.")
    else
        warn("Failed to load Infinite Yield: " .. tostring(err))
    end

    -- Safeguard CoreGui after loading Infinite Yield
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
end

return InfiniteYield
