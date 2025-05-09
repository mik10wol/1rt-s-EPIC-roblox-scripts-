-- Function to create a Highlight effect
local user = "Roblox"

local function createHighlight(model)
	if model:IsA("Model") then
		local highlight = Instance.new("Highlight")
		highlight.Adornee = model
		highlight.FillColor = Color3.fromRGB(255, 255, 0) -- Yellow
		highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- White outline
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Parent = model
	end
end

-- Function to find and highlight the model
local function findAndHighlight()
	local model = workspace:FindFirstChild(user, true)
	if model and not model:FindFirstChildOfClass("Highlight") then
		createHighlight(model)
		print(user .. " found and highlighted!")
	end
end

-- Initial search
findAndHighlight()

-- Keep checking in case it appears later
workspace.DescendantAdded:Connect(function(descendant)
	if descendant:IsA("Model") and descendant.Name == user then
		task.wait(0.1)
		findAndHighlight()
	end
end)
