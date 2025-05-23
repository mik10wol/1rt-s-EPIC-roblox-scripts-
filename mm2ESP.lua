-- Combined Highlighter + Sound Alert Script with Teleport Feature
-- LocalScript in StarterPlayerScripts

local Workspace = game:GetService("Workspace")
local SoundService = game:GetService("SoundService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local GunDropReference = nil

-- === CONFIGURATION ===
local highlightModel = true -- Set this to true to highlight the whole model instead of just torso

-- === Sound Setup ===

local function getOrCreateAlertSound()
	local existing = SoundService:FindFirstChild("HighlightAlertSound")
	if existing then return existing end

	local sound = Instance.new("Sound")
	sound.Name = "HighlightAlertSound"
	sound.SoundId = "rbxassetid://12221967"
	sound.Volume = 1
	sound.Looped = false
	sound.Parent = SoundService
	return sound
end

local function playAlert()
	local sound = getOrCreateAlertSound()
	sound:Play()
end

-- === Highlighting Functions ===

local function highlightToolHolder(model, toolName, color, highlightName, logPrefix)
	if model:FindFirstChild(highlightName) then return end

	local adornee
	if highlightModel then
		adornee = model
	else
		adornee = model:FindFirstChild("UpperTorso") or model:FindFirstChild("Torso") or model
	end

	if adornee then
		print("[" .. logPrefix .. " Detected] Model:", model.Name)

		local highlight = Instance.new("Highlight")
		highlight.Name = highlightName
		highlight.Adornee = adornee
		highlight.FillColor = color
		highlight.OutlineColor = color
		highlight.FillTransparency = 0.3
		highlight.OutlineTransparency = 0
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Parent = model

		playAlert()
	end
end

local function monitorModelForTools(model)
	model.ChildAdded:Connect(function(child)
		if child:IsA("Tool") then
			if child.Name == "Knife" then
				highlightToolHolder(model, "Knife", Color3.fromRGB(255, 0, 0), "KnifeHighlight", "Knife")
			elseif child.Name == "Gun" then
				highlightToolHolder(model, "Gun", Color3.fromRGB(0, 0, 255), "GunHighlight", "Gun")
			end
		end
	end)
end

local function highlightGunDrop(model)
	local gunDrop = model:FindFirstChild("GunDrop")
	if gunDrop and gunDrop:IsA("BasePart") and not gunDrop:FindFirstChild("GunDropHighlight") then
		print("[GunDrop Found] In model:", model.Name)

		local highlight = Instance.new("Highlight")
		highlight.Name = "GunDropHighlight"
		highlight.Adornee = gunDrop
		highlight.FillColor = Color3.fromRGB(0, 255, 0)
		highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
		highlight.FillTransparency = 0.1
		highlight.OutlineTransparency = 0
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Parent = gunDrop

		GunDropReference = gunDrop
		playAlert()
	elseif gunDrop then
		GunDropReference = gunDrop
	end
end

-- === Initial Pass on Existing Models ===

for _, obj in pairs(Workspace:GetChildren()) do
	if obj:IsA("Model") then
		monitorModelForTools(obj)
		highlightGunDrop(obj)
	end
end

-- === Watch for New Models & Children ===

Workspace.ChildAdded:Connect(function(obj)
	if obj:IsA("Model") then
		monitorModelForTools(obj)
		highlightGunDrop(obj)

		obj.ChildAdded:Connect(function(child)
			if child.Name == "GunDrop" then
				task.wait(0.1)
				highlightGunDrop(obj)
			end
		end)
	end
end)

-- === Teleport to GunDrop and Back (on L key press) ===

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.L then
		local character = LocalPlayer.Character
		local hrp = character and character:FindFirstChild("HumanoidRootPart")

		if hrp and GunDropReference then
			local originalCFrame = hrp.CFrame
			local targetCFrame = GunDropReference.CFrame + Vector3.new(0, 3, 0)

			hrp.CFrame = targetCFrame
			task.wait(0.05)
			hrp.CFrame = originalCFrame
		end
	end
end)
