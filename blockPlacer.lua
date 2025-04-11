local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if not gameProcessedEvent then -- Make sure the game isn't already handling this input
		if input.KeyCode == Enum.KeyCode.L then
			-- Player pressed the 'L' key!
			local character = localPlayer.Character
			if character then
				local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
				if humanoidRootPart then
					-- Get the player's current position
					local playerPosition = humanoidRootPart.Position

					-- Create the new block
					local newPart = Instance.new("Part")
					newPart.Size = Vector3.new(5, 5, 5)
					newPart.Anchored = true -- So it doesn't fall
					newPart.Position = playerPosition
					newPart.Parent = game.Workspace
          newPart.CanCollide = false
          newPart.Transparency = 0.5
          task.wait(3)
          newPart.CanCollide = true
          newPart.Transparency = 0
				end
			end
		end
	end
end)
