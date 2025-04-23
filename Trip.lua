local player = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")

userInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end -- Ignore input if the game already handled it

	if input.KeyCode == Enum.KeyCode.B then
		local character = player.Character
		if character and character:FindFirstChild("Humanoid") then
			local humanoid = character.Humanoid
			humanoid.PlatformStand = not humanoid.PlatformStand
		end
	end
end)
