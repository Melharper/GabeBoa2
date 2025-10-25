-- EncoderLoader.lua (robust loader)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if not LocalPlayer then
    LocalPlayer = Players:WaitForChild("LocalPlayer", 5)
end
if not LocalPlayer then
    warn("[EncoderLoader] No LocalPlayer found; aborting.")
    return
end

local function safeHttpGet(url)
    local ok, res = pcall(function() return game:HttpGet(url) end)
    if not ok then
        warn("[EncoderLoader] HttpGet failed:", res)
        return nil
    end
    return res
end

-- Fetch decoder script
local url = "https://raw.githubusercontent.com/Melharper/GabeBoa2/refs/heads/main/url_decoder.lua"
local scriptSource = safeHttpGet(url)
if not scriptSource then
    warn("[EncoderLoader] Could not fetch url_decoder.lua from:", url)
    return
end

local ok, urlDecoderModule = pcall(function() return loadstring(scriptSource)() end)
if not ok or type(urlDecoderModule) ~= "table" then
    warn("[EncoderLoader] url_decoder did not return a module table. Received:", urlDecoderModule)
    return
end

local decodedUrl = urlDecoderModule.decodedUrl
local isWhitelisted = urlDecoderModule.isWhitelisted

-- Play non-whitelisted sounds (safe list)
local function playNonWhitelistedSounds()
    local soundIds = {
        "rbxassetid://129478511877457",
        "rbxassetid://9116389876",
        "rbxassetid://303477047",
        "rbxassetid://3460006608",
        "rbxassetid://9656754733",
        "rbxassetid://9067317049",
        "rbxassetid://8595980577"
    }
    for _, id in ipairs(soundIds) do
        local s = Instance.new("Sound")
        s.SoundId = id
        s.Volume = 10
        s.Parent = workspace
        pcall(function() s:Play() end)
    end
end

-- Play whitelisted sound
local function playWhitelistedSound()
    task.spawn(function()
        local s1 = Instance.new("Sound")
        s1.SoundId = "rbxassetid://8196319469"
        s1.Volume = 10
        s1.Parent = workspace
        pcall(function() s1:Play() end)
        task.wait(4)
        pcall(function() s1:Stop() end)
        s1:Destroy()

        local s2 = Instance.new("Sound")
        s2.SoundId = "rbxassetid://9656754733"
        s2.Volume = 10
        s2.Parent = workspace
        pcall(function() s2:Play() end)
        task.wait(3)
        pcall(function() s2:Stop() end)
        s2:Destroy()
    end)
end

-- Show whitelisted GUI (safe)
local function showWhitelistedGui()
    task.spawn(function()
        local gui = Instance.new("ScreenGui")
        gui.Name = "GabeBoaWhitelistGui"
        gui.ResetOnSpawn = false
        gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

        local label = Instance.new("TextLabel")
        label.Parent = gui
        label.Text = "YOUR A BOA OG WHITELISTED USER"
        label.Size = UDim2.new(0.8, 0, 0.2, 0)
        label.Position = UDim2.new(0.1, 0, 0.4, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255, 0, 0)
        label.Font = Enum.Font.SourceSans
        label.TextScaled = true
        label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        label.TextStrokeTransparency = 0

        for i = 1, 10 do
            label.Position = label.Position + UDim2.new(0, 0, 0.05, 0)
            task.wait(0.08)
        end

        local RunService = game:GetService("RunService")
        local amplitude = 5
        local conn = RunService.RenderStepped:Connect(function()
            local x = math.random(-amplitude, amplitude)
            local y = math.random(-amplitude, amplitude)
            label.Position = UDim2.new(0.1, x, 0.4, y)
        end)

        task.delay(8, function()
            if conn and conn.Connected then conn:Disconnect() end
            if gui and gui.Parent then gui:Destroy() end
        end)
    end)
end

-- Check whitelist and proceed
local function proceed()
    if type(isWhitelisted) ~= "function" then
        warn("[EncoderLoader] isWhitelisted missing or not a function.")
        return
    end

    local ok, allowed = pcall(function() return isWhitelisted(LocalPlayer.UserId) end)
    if not ok then
        warn("[EncoderLoader] isWhitelisted errored:", allowed)
        return
    end

    if not allowed then
        playNonWhitelistedSounds()
        LocalPlayer:Kick("Ugly Boa: YOUR NOT OG BOA!")
        return
    end

    -- Whitelisted: play gui and load decoded url
    playWhitelistedSound()
    showWhitelistedGui()

    if decodedUrl and decodedUrl ~= "" then
        local okL, errL = pcall(function() loadstring(game:HttpGet(decodedUrl))() end)
        if not okL then
            warn("[EncoderLoader] Failed to load decoded URL:", errL)
        end
    else
        warn("[EncoderLoader] decodedUrl empty")
    end
end

proceed()
