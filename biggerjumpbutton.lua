-- LocalScript: Enlarge Jump Button for Mobile
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local userInputService = game:GetService("UserInputService")

-- Check if on Mobile
if userInputService.TouchEnabled and not userInputService.KeyboardEnabled then
    -- Wait for TouchGui to load
    local touchGui = playerGui:WaitForChild("TouchGui", 5)
    if not touchGui then
        warn("TouchGui not found! (Are you on PC?")
        return
    end

    -- Find the JumpButton
    local jumpButton
    while not jumpButton do
        jumpButton = touchGui:FindFirstChild("JumpButton", true)
        task.wait(0.1)
    end

    -- Enlarge the button
    jumpButton.Size = UDim2.new(0, 150, 0, 150) -- Bigger size
    jumpButton.Position = UDim2.new(1, -170, 1, -170) -- Move it a bit if needed
    print("Jump button enlarged for mobile!")
end
