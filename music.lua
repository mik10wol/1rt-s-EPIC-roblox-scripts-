-- LocalScript: Music Player

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")

-- Create GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MusicPlayerGui"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local musicGui = Instance.new("Frame")
musicGui.Size = UDim2.new(0, 320, 0, 240)
musicGui.Position = UDim2.new(0.5, -160, 0.5, -120)
musicGui.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
musicGui.BackgroundTransparency = 1 -- Start hidden
musicGui.Visible = false
musicGui.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = musicGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🎵 Music Player"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.Parent = musicGui

local function createButton(text, pos)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 90, 0, 35)
	button.Position = pos
	button.Text = text
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.Gotham
	button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	button.TextSize = 18
	button.Parent = musicGui

	local corner = Instance.new("UICorner")
	corner.Parent = button

	return button
end

local playButton = createButton("▶ Play", UDim2.new(0, 10, 0, 50))
local pauseButton = createButton("⏸ Pause", UDim2.new(0, 110, 0, 50))
local restartButton = createButton("⏮ Restart", UDim2.new(0, 210, 0, 50))
local loopButton = createButton("🔁 Loop: Off", UDim2.new(0, 10, 0, 100))

local idBox = Instance.new("TextBox")
idBox.Size = UDim2.new(0, 200, 0, 35)
idBox.Position = UDim2.new(0, 10, 0, 160)
idBox.PlaceholderText = "Enter Music ID"
idBox.Text = ""
idBox.Font = Enum.Font.Gotham
idBox.TextSize = 18
idBox.TextColor3 = Color3.fromRGB(0, 0, 0)
idBox.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
idBox.ClearTextOnFocus = false
idBox.Parent = musicGui

local idCorner = Instance.new("UICorner")
idCorner.Parent = idBox

local setIdButton = createButton("Set ID", UDim2.new(0, 220, 0, 160))

-- Sound setup
local musicSound = Instance.new("Sound")
musicSound.Parent = workspace
musicSound.Volume = 0.5

-- Buttons actions
playButton.MouseButton1Click:Connect(function()
	musicSound:Play()
end)

pauseButton.MouseButton1Click:Connect(function()
	musicSound:Pause()
end)

restartButton.MouseButton1Click:Connect(function()
	musicSound:Stop()
	musicSound:Play()
end)

local looping = false
loopButton.MouseButton1Click:Connect(function()
	looping = not looping
	musicSound.Looped = looping
	loopButton.Text = looping and "🔁 Loop: On" or "🔁 Loop: Off"
end)

setIdButton.MouseButton1Click:Connect(function()
	local id = idBox.Text
	if id and tonumber(id) then
		musicSound.SoundId = "rbxassetid://" .. id
	else
		warn("Invalid ID entered")
	end
end)

-- Toggling the GUI
local isGuiVisible = false

function toggleGui()
	isGuiVisible = not isGuiVisible

	if isGuiVisible then
		musicGui.Visible = true
		tweenService:Create(musicGui, TweenInfo.new(0.25), {BackgroundTransparency = 0.2}):Play()
	else
		tweenService:Create(musicGui, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
		task.delay(0.25, function()
			musicGui.Visible = false
		end)
	end
end

userInputService.InputBegan:Connect(function(input, isTyping)
	if isTyping then return end -- don't trigger while typing into a box
	if input.KeyCode == Enum.KeyCode.L then
		toggleGui()
	end
end)
