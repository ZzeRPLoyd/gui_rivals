getgenv().SilentConfig = {
	HitPart = "UpperTorso",
	FOVRadius = 300,
	ShowFOV = true,
	State = false
}

local Players = game:GetService("Players")
local CCS = game:GetService("CollectionService")
local RS = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()
local Utility = require(RS.Modules.Utility)
local oldFN = Utility.Raycast

local function CreateFovCircle(radius, color, thickness)
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "FovCircle"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.DisplayOrder = 10
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.Parent = game.CoreGui

	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(0, radius * 2, 0, radius * 2)
	Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.BackgroundTransparency = 1
	Frame.Parent = ScreenGui

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = Frame

	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = color or Color3.fromRGB(255, 255, 255)
	UIStroke.Thickness = thickness or 1
	UIStroke.Parent = Frame

	return ScreenGui, Frame
end

local gui, FOV = CreateFovCircle(100, nil, 1)


game:GetService("RunService").RenderStepped:Connect(function()
	local radius = getgenv().SilentConfig.FOVRadius,getgenv().SilentConfig.FOVRadius
	
	FOV.Position =UDim2.fromOffset( workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
	FOV.Size = UDim2.fromOffset(radius, radius)
	FOV.Visible = getgenv().SilentConfig.ShowFOV and getgenv().SilentConfig.State
end)

local SILENT = {}

local function getClosestObjectFromMouse(character : Model)
	local joints = {
		'Head',
		
		'UpperTorso',
		
		"RightUpperLeg",
		'RightLowerLeg',
		"LeftUpperLeg",
		'LeftLowerLeg',
		
		"RightUpperArm",
		'RightLowerArm',
		
		"LeftUpperArm",
		'LeftLowerArm',
	}
	
	local onRandom = math.random() <= 0.1
	local dis, best = 1e12, nil
	local mousePos = mouse.Hit.Position
	
	if onRandom then
		return joints[math.random(1, #joints)]
	end
	
	for _, name in joints do
		local part = character:FindFirstChild(name, true)
		
		if not part then
			continue;
		end
		
		local distance = (mousePos - part.Position).Magnitude
		
		if distance < dis then
			dis = distance
			best = name
		end
	end
	
	
	
	return best or joints[2]
end

local function getClosesObject()
	local screen_center = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
	local closestObject = nil
	local hitPart = getgenv().SilentConfig.HitPart
	local last_fov = getgenv().SilentConfig.FOVRadius
	for _, character in CCS:GetTagged("Entity") do
		if character == LocalPlayer.Character then 
			continue 
		end
		
		if hitPart == 'Closest' then
			hitPart = getClosestObjectFromMouse(character)
		end
		
		local object = character:FindFirstChild(hitPart, true)
		if not object or not object:IsA("BasePart") then 
			continue 
		end
		local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(object.Position)
		if not onScreen then 
			continue 
		end
		local newFov = (screen_center - Vector2.new(pos.X, pos.Y)).Magnitude
		if newFov < last_fov then
			last_fov = newFov
			closestObject = object
		end
	end

	return closestObject
end

Utility.Raycast = function(self, phem19, phem20, phem21, phem22, phem23, phem24)
	if type(phem21) ~= "number" or phem21 < 100 or not getgenv().SilentConfig.State then
		return oldFN(self, phem19, phem20, phem21, phem22, phem23, phem24)
	end

	local object = getClosesObject()

	if not object then
		return oldFN(self, phem19, phem20, phem21, phem22, phem23, phem24)
	end

	local objectPosition = object.Position
	local direction = (objectPosition - phem19).Unit
	local distance = (objectPosition - phem19).Magnitude
	if distance > phem21 then
		distance = phem21
		objectPosition = phem19 + (direction * phem21)
	end
	
	return {
		Position = objectPosition,
		Distance = distance,
		Instance = object,
		Material = object.Material,
		Normal = -direction
	}
end

SILENT.configValueChanged = function(name, value)
warn('silent config set', name, value)
end

SILENT.setConfig = function(config)
	for n, v in config do
		getgenv().SilentConfig[n] = v

		SILENT.configValueChanged(n, v)
	end
end

warn('Silent injected')

return SILENT
