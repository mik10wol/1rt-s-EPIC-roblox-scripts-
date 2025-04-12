local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local elevatorPart
local isMoving = false
local isCreated = false
local speed = 2

-- Reset elevator position
local function resetElevator()
	if elevatorPart then
		local character = player.Character or player.CharacterAdded:Wait()
		local root = character:WaitForChild("HumanoidRootPart")
		elevatorPart.Position = root.Position - Vector3.new(0, 3, 0)
	end
end

-- GUI creation
local function createGUI()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "ElevatorGui"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = player:WaitForChild("PlayerGui")

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 250, 0, 100)
	frame.Position = UDim2.new(0.5, -125, 0.85, 0)
	frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	frame.BorderSizePixel = 0
	frame.Active = true
	frame.Draggable = true
	frame.Parent = screenGui

	local label = Instance.new("TextLabel")
	label.Text = "Elevator Speed"
	label.Size = UDim2.new(1, 0, 0.3, 0)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Font = Enum.Font.SourceSans
	label.TextScaled = true
	label.Parent = frame

	local slider = Instance.new("TextButton")
	slider.Size = UDim2.new(0.9, 0, 0.3, 0)
	slider.Position = UDim2.new(0.05, 0, 0.35, 0)
	slider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	slider.Text = tostring(speed)
	slider.TextColor3 = Color3.new(1, 1, 1)
	slider.Font = Enum.Font.SourceSans
	slider.TextScaled = true
	slider.AutoButtonColor = true
	slider.Parent = frame

	slider.MouseButton1Click:Connect(function()
		speed += 1
		if speed > 10 then speed = 1 end
		slider.Text = tostring(speed)
	end)

	local resetButton = Instance.new("TextButton")
	resetButton.Size = UDim2.new(0.9, 0, 0.25, 0)
	resetButton.Position = UDim2.new(0.05, 0, 0.7, 0)
	resetButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
	resetButton.Text = "Reset Elevator"
	resetButton.TextColor3 = Color3.new(1, 1, 1)
	resetButton.Font = Enum.Font.SourceSansBold
	resetButton.TextScaled = true
	resetButton.AutoButtonColor = true
	resetButton.Parent = frame

	resetButton.MouseButton1Click:Connect(resetElevator)
end

-- Create the elevator platform
local function createElevator()
	local character = player.Character or player.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart")

	elevatorPart = Instance.new("Part")
	elevatorPart.Size = Vector3.new(6, 1, 6)
	elevatorPart.Anchored = true
	elevatorPart.CanCollide = true
	elevatorPart.Position = root.Position - Vector3.new(0, 3, 0)
	elevatorPart.Name = "ElevatorPart"
	elevatorPart.BrickColor = BrickColor.new("Really black")
	elevatorPart.Parent = workspace

	isCreated = true
end

-- Move elevator upward
RunService.RenderStepped:Connect(function(deltaTime)
	if isMoving and elevatorPart then
		elevatorPart.Position += Vector3.new(0, speed * deltaTime, 0)
	end
end)

-- Key input
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.P then
		if not isCreated then
			createElevator()
			createGUI()
			isMoving = true
		else
			isMoving = not isMoving
		end
	end
end)
