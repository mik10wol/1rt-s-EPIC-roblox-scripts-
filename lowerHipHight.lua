-- Get the local player
local player = game.Players.LocalPlayer

-- Check if the player exists
if not player or not player.Character or not player.Character:FindFirstChild("Humanoid") then
	warn("Player or Humanoid not found!")
	return
end

-- Get the Humanoid object
local humanoid = player.Character:WaitForChild("Humanoid")

-- Store the original hip height
local originalHipHeight = humanoid.HipHeight

-- Define the key to listen for
local targetKey = Enum.KeyCode.U

-- Function to handle key press
local function onInputBegan(input, gameProcessedEvent)
	if not gameProcessedEvent and input.KeyCode == targetKey then
		-- When the 'U' key is pressed, set the hip height to -2
		humanoid.HipHeight = -2
	end
end

-- Function to handle key release
local function onInputEnded(input, gameProcessedEvent)
	if not gameProcessedEvent and input.KeyCode == targetKey then
		-- When the 'U' key is released, set the hip height back to the original value
		humanoid.HipHeight = originalHipHeight
	end
end

-- Connect input events to the functions
game:GetService("UserInputService").InputBegan:Connect(onInputBegan)
game:GetService("UserInputService").InputEnded:Connect(onInputEnded)

print("Script started! Press and hold 'U' to lower your hip height.")
