local player = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

userInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end

	local character = player.Character
	if not (character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid")) then return end

	local humanoid = character.Humanoid
	local rootPart = character.HumanoidRootPart

	if input.KeyCode == Enum.KeyCode.B then
		humanoid.PlatformStand = not humanoid.PlatformStand

	elseif input.KeyCode == Enum.KeyCode.N then
		humanoid.PlatformStand = true

		-- Clean up any existing forces
		for _, obj in ipairs(rootPart:GetChildren()) do
			if obj:IsA("BodyMover") then obj:Destroy() end
		end

		-- Create strong jittery velocity but centered around 0
		local bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.Velocity = Vector3.new(
			math.random(-50, 50),
			math.random(-20, 20),
			math.random(-50, 50)
	 )
		bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
		bodyVelocity.P = 5000
		bodyVelocity.Parent = rootPart

		-- Apply strong chaotic spin
		local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
		bodyAngularVelocity.AngularVelocity = Vector3.new(
			math.random(-30, 30),
			math.random(-30, 30),
			math.random(-30, 30)
		)
		bodyAngularVelocity.MaxTorque = Vector3.new(100000, 100000, 100000)
		bodyAngularVelocity.P = 5000
		bodyAngularVelocity.Parent = rootPart

		-- Jitter in place for a short time
		task.delay(1.5, function()
			if bodyVelocity and bodyVelocity.Parent then bodyVelocity:Destroy() end
			if bodyAngularVelocity and bodyAngularVelocity.Parent then bodyAngularVelocity:Destroy() end
		end)
	end
end)
