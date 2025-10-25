-- BoaHudGabey.lua
-- Handles GUI + Sound effects for Gabe&Snicks BOA Cult

local BoaHud = {}

-- Play the whitelisted sound
function BoaHud.playWhitelistedSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://8196319469"
    sound.Volume = 10
    sound.Parent = game.Workspace
    sound:Play()

    -- Stop the first sound after 4 seconds
    task.wait(4)
    sound:Stop()

    -- Play the secondary sound
    local extraSound = Instance.new("Sound")
    extraSound.SoundId = "rbxassetid://9656754733"
    extraSound.Volume = 10
    extraSound.Parent = game.Workspace
    extraSound:Play()
end

-- Show the BOA HUD GUI
function BoaHud.showWhitelistedGui()
    local player = game.Players.LocalPlayer
    if not player then return end

    local gui = Instance.new("ScreenGui")
    gui.Name = "BoaHUDGui"
    gui.Parent = player:WaitForChild("PlayerGui")

    local label = Instance.new("TextLabel")
    label.Parent = gui
    label.Text = "YOU ARE A BOA OG WHITELISTED USER"
    label.Size = UDim2.new(0.8, 0, 0.2, 0)
    label.Position = UDim2.new(0.1, 0, 0.4, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 0, 0)
    label.Font = Enum.Font.FredokaOne
    label.TextScaled = true
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextStrokeTransparency = 0

    -- Blood drip effect
    for i = 1, 10 do
        label.Position = label.Position + UDim2.new(0, 0, 0.05, 0)
        task.wait(0.1)
    end

    -- Shake effect
    local runService = game:GetService("RunService")
    local amplitude = 5
    local connection
    connection = runService.RenderStepped:Connect(function()
        local xOffset = math.random(-amplitude, amplitude)
        local yOffset = math.random(-amplitude, amplitude)
        label.Position = UDim2.new(0.1, xOffset, 0.4, yOffset)
        task.wait(0.02)
    end)

    -- Stop shaking after 8 seconds
    task.delay(8, function()
        if connection then connection:Disconnect() end
        gui:Destroy()
    end)
end

-- Initialize automatically
task.spawn(function()
    BoaHud.playWhitelistedSound()
    BoaHud.showWhitelistedGui()
end)

return BoaHud
