print("Variable loading started")

-- LocalScript: Character Dragging + Animations

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local userInputService = game:GetService("UserInputService")

-- Loads image IDs
local idle = "rbxassetid://115997552431511"
local freaky = "rbxassetid://124135290073730"
local hungry = "rbxassetid://101296723539960"
local look = "rbxassetid://78372339411031"
local newFile = "rbxassetid://138295410719534"
local paperPlane = "rbxassetid://89061659083856"
local reading = "rbxassetid://132200731402626"
local sniff = "rbxassetid://139347438046249"
local pablo = "rbxassetio://92187044909923"

-- Create the ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DraggableGui"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- Create the ImageLabel
local imageLabel = Instance.new("ImageLabel")
imageLabel.Name = "DraggableImage"
imageLabel.Size = UDim2.new(0, 150, 0, 150)
imageLabel.Position = UDim2.new(0.5, -75, 0.5, -75)
imageLabel.BackgroundTransparency = 1
imageLabel.Parent = screenGui
imageLabel.ScaleType = Enum.ScaleType.Crop
imageLabel.Visible = true

-- Dragging functionality
local dragging = false
local mousePos, framePos

imageLabel.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		mousePos = input.Position
		framePos = imageLabel.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

userInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - mousePos
		imageLabel.Position = UDim2.new(
			framePos.X.Scale,
			framePos.X.Offset + delta.X,
			framePos.Y.Scale,
			framePos.Y.Offset + delta.Y
		)
	end
end)

-- Character Emote Animation Loop
task.wait(6)

while true do
	local emotes = {freaky, hungry, look, newFile, paperPlane, reading, sniff, pablo}
	local randomEmote = emotes[math.random(1, #emotes)]
	imageLabel.Image = randomEmote
	task.wait(3)
	imageLabel.Image = idle
	task.wait(math.random(5,15))
end
