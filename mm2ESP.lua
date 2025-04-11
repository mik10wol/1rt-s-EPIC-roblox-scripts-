-- Combined Highlighter + Sound Alert Script
-- LocalScript in StarterPlayerScripts

local Workspace = game:GetService("Workspace")
local SoundService = game:GetService("SoundService")

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

	local adornee = model:FindFirstChild("UpperTorso") or model:FindFirstChild("Torso") or model
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
		highlight.OutlineColor = Color3.fromRGB(0, 255,
