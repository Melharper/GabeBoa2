-- Remote Spy Tool with Clipboard Copy
-- Monitors RemoteEvent and RemoteFunction calls, and provides an option to copy details.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Create GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RemoteSpyGUI"
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.4, 0, 0.6, 0)
frame.Position = UDim2.new(0.3, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Remote Spy Tool"
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Parent = frame

local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = UDim2.new(1, 0, 0.8, 0)
scrollingFrame.Position = UDim2.new(0, 0, 0.1, 0)
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollingFrame.ScrollBarThickness = 8
scrollingFrame.Parent = frame

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Parent = scrollingFrame

local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(1, 0, 0.1, 0)
copyButton.Position = UDim2.new(0, 0, 0.9, 0)
copyButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyButton.TextScaled = true
copyButton.Text = "Copy Last Remote Info"
copyButton.Font = Enum.Font.SourceSansBold
copyButton.Parent = frame

local lastRemoteData = ""

-- Function to log remote calls
local function logRemote(remoteType, remote, args)
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -10, 0, 30)
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextScaled = true
    textLabel.BackgroundTransparency = 1
    textLabel.Text = string.format("[%s] %s - Args: %s", remoteType, remote:GetFullName(), tostring(args))
    textLabel.Parent = scrollingFrame

    -- Save last remote data for copying
    lastRemoteData = string.format("Remote Type: %s\nRemote Path: %s\nArguments: %s", remoteType, remote:GetFullName(), tostring(args))

    -- Update canvas size
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #scrollingFrame:GetChildren() * 30)
end

-- Monitor all remote calls
for _, remote in ipairs(ReplicatedStorage:GetDescendants()) do
    if remote:IsA("RemoteEvent") then
        remote.OnClientEvent:Connect(function(...)
            logRemote("RemoteEvent", remote, {...})
        end)
    elseif remote:IsA("RemoteFunction") then
        local originalInvoke = remote.InvokeServer
        remote.InvokeServer = function(_, ...)
            logRemote("RemoteFunction", remote, {...})
            return originalInvoke(remote, ...)
        end
    end
end

-- Copy last remote data to clipboard
copyButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(lastRemoteData)
        print("Copied to clipboard: " .. lastRemoteData)
    else
        print("Clipboard copying is not supported.")
    end
end)

print("Remote Spy Tool initialized!")
