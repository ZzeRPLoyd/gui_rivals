--==================================================
-- 2D CORNER ESP
--==================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CCS = game:GetService('CollectionService')

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera


--==================================================
-- SETTINGS
--==================================================

local Settings = {

	-- ELEMENTS
	Box = false,
	HealthBar = false,
	HealthText = false,
	DisplayName = false,
	Distance = false,

	-- DISTANCE
	MaxDistance = 2000,

	-- BOX
	BoxColor = Color3.fromRGB(255, 0, 0),
	BoxThickness = 2,

	CornerLength = 0.22,
	MinCornerSize = 8,
	MaxCornerSize = 35,

	-- BOX SCALE
	BoxScale = 1.5,

	MaxBoxHeight = 900,

	BoxWidth = 0.55,

	-- TEXT
	TextColor = Color3.fromRGB(21, 255, 0),

	NameSize = 13,
	DistanceSize = 11,
	HealthTextSize = 10,

	-- HEALTH BAR
	HealthBarWidth = 5,

	-- Расстояние между box и HP bar
	HealthBarOffset = 8,

	-- Расстояние текста слева от HP bar
	HealthTextOffset = 6,

	HealthHighColor =
		Color3.fromRGB(
			70,
			220,
			120
		),

	HealthMediumColor =
		Color3.fromRGB(
			240,
			190,
			70
		),

	HealthLowColor =
		Color3.fromRGB(
			240,
			70,
			70
		)
}


--==================================================
-- GUI
--==================================================

local espModule = {}

local ESPGui =
	Instance.new("ScreenGui")

ESPGui.Name =
	"CornerESP"

ESPGui.IgnoreGuiInset =
	true

ESPGui.ResetOnSpawn =
	false

ESPGui.ZIndexBehavior =
	Enum.ZIndexBehavior.Sibling

ESPGui.Parent =
	game:GetService("CoreGui")


--==================================================
-- ESP DATA
--==================================================

local ESPObjects = {}


--==================================================
-- CREATE LINE
--==================================================

local function CreateLine(Parent)

	local Line =
		Instance.new("Frame")

	Line.BackgroundColor3 =
		Settings.BoxColor

	Line.BorderSizePixel =
		0

	Line.Parent =
		Parent

	return Line
end


--==================================================
-- CREATE CORNER BOX
--==================================================

local function CreateCornerBox(Parent)

	local Folder =
		Instance.new("Folder")

	Folder.Name =
		"CornerBox"

	Folder.Parent =
		Parent


	local TL_H =
		CreateLine(Folder)

	local TL_V =
		CreateLine(Folder)


	local TR_H =
		CreateLine(Folder)

	local TR_V =
		CreateLine(Folder)


	local BL_H =
		CreateLine(Folder)

	local BL_V =
		CreateLine(Folder)


	local BR_H =
		CreateLine(Folder)

	local BR_V =
		CreateLine(Folder)


	return {

		TL_H = TL_H,
		TL_V = TL_V,

		TR_H = TR_H,
		TR_V = TR_V,

		BL_H = BL_H,
		BL_V = BL_V,

		BR_H = BR_H,
		BR_V = BR_V
	}
end


--==================================================
-- UPDATE CORNER BOX
--==================================================

local function UpdateCornerBox(
	Corners,
	Width,
	Height
)

	local CornerWidth =
		math.clamp(
			Width * Settings.CornerLength,
			Settings.MinCornerSize,
			Settings.MaxCornerSize
		)

	local CornerHeight =
		math.clamp(
			Height * Settings.CornerLength,
			Settings.MinCornerSize,
			Settings.MaxCornerSize
		)

	local Thickness =
		Settings.BoxThickness


	-- TOP LEFT

	Corners.TL_H.Position =
		UDim2.fromOffset(
			0,
			0
		)

	Corners.TL_H.Size =
		UDim2.fromOffset(
			CornerWidth,
			Thickness
		)


	Corners.TL_V.Position =
		UDim2.fromOffset(
			0,
			0
		)

	Corners.TL_V.Size =
		UDim2.fromOffset(
			Thickness,
			CornerHeight
		)


	-- TOP RIGHT

	Corners.TR_H.Position =
		UDim2.fromOffset(
			Width - CornerWidth,
			0
		)

	Corners.TR_H.Size =
		UDim2.fromOffset(
			CornerWidth,
			Thickness
		)


	Corners.TR_V.Position =
		UDim2.fromOffset(
			Width - Thickness,
			0
		)

	Corners.TR_V.Size =
		UDim2.fromOffset(
			Thickness,
			CornerHeight
		)


	-- BOTTOM LEFT

	Corners.BL_H.Position =
		UDim2.fromOffset(
			0,
			Height - Thickness
		)

	Corners.BL_H.Size =
		UDim2.fromOffset(
			CornerWidth,
			Thickness
		)


	Corners.BL_V.Position =
		UDim2.fromOffset(
			0,
			Height - CornerHeight
		)

	Corners.BL_V.Size =
		UDim2.fromOffset(
			Thickness,
			CornerHeight
		)


	-- BOTTOM RIGHT

	Corners.BR_H.Position =
		UDim2.fromOffset(
			Width - CornerWidth,
			Height - Thickness
		)

	Corners.BR_H.Size =
		UDim2.fromOffset(
			CornerWidth,
			Thickness
		)


	Corners.BR_V.Position =
		UDim2.fromOffset(
			Width - Thickness,
			Height - CornerHeight
		)

	Corners.BR_V.Size =
		UDim2.fromOffset(
			Thickness,
			CornerHeight
		)
end


--==================================================
-- CREATE ESP
--==================================================

local function CreateESP(character)

	if character == LocalPlayer.Character then
		return
	end

	if character.Name == LocalPlayer.Name then
		return;
	end

	if ESPObjects[character] then
		return ESPObjects[character]
	end


	--==================================================
	-- CONTAINER
	--==================================================

	local Container =
		Instance.new("Frame")

	Container.Name =
		character.Name

	Container.BackgroundTransparency =
		1

	Container.BorderSizePixel =
		0

	Container.Visible =
		false

	Container.Parent =
		ESPGui


	--==================================================
	-- CORNER BOX
	--==================================================

	local Corners =
		CreateCornerBox(
			Container
		)


	--==================================================
	-- DISPLAY NAME
	--==================================================

	local Name =
		Instance.new("TextLabel")

	Name.Name =
		"DisplayName"

	Name.BackgroundTransparency =
		1

	Name.AnchorPoint =
		Vector2.new(
			0.5,
			1
		)

	Name.Position =
		UDim2.new(
			0.5,
			0,
			0,
			-5
		)

	Name.Size =
		UDim2.new(
			1,
			150,
			0,
			20
		)

	Name.Text =
		character.Name

	Name.TextColor3 =
		Settings.TextColor

	Name.TextStrokeColor3 =
		Color3.fromRGB(
			0,
			0,
			0
		)

	Name.TextStrokeTransparency =
		0

	Name.Font =
		Enum.Font.GothamBold

	Name.TextSize =
		Settings.NameSize

	Name.TextXAlignment =
		Enum.TextXAlignment.Center

	Name.Parent =
		Container


	--==================================================
	-- HEALTH BACKGROUND
	--==================================================

	local HealthBackground =
		Instance.new("Frame")

	HealthBackground.Name =
		"HealthBackground"

	HealthBackground.BackgroundColor3 =
		Color3.fromRGB(
			20,
			20,
			20
		)

	HealthBackground.BorderSizePixel =
		0

	HealthBackground.Parent =
		Container


	--==================================================
	-- HEALTH BAR
	--==================================================

	local HealthBar =
		Instance.new("Frame")

	HealthBar.Name =
		"HealthBar"

	HealthBar.BackgroundColor3 =
		Settings.HealthHighColor

	HealthBar.BorderSizePixel =
		0

	HealthBar.AnchorPoint =
		Vector2.new(
			0,
			1
		)

	HealthBar.Position =
		UDim2.new(
			0,
			0,
			1,
			0
		)

	HealthBar.Size =
		UDim2.new(
			1,
			0,
			1,
			0
		)

	HealthBar.Parent =
		HealthBackground


	--==================================================
	-- HEALTH TEXT
	--==================================================

	local HealthText =
		Instance.new("TextLabel")

	HealthText.Name =
		"HealthText"

	HealthText.BackgroundTransparency =
		1

	-- ВАЖНО:
	-- anchor справа и position у левого края бара.
	-- Поэтому текст находится СЛЕВА от HP bar.

	HealthText.AnchorPoint =
		Vector2.new(
			1,
			0.5
		)

	HealthText.Position =
		UDim2.new(
			0,
			-Settings.HealthTextOffset,
			0.5,
			0
		)

	HealthText.Size =
		UDim2.fromOffset(
			80,
			18
		)

	HealthText.TextColor3 =
		Color3.fromRGB(
			255,
			255,
			255
		)

	HealthText.TextStrokeColor3 =
		Color3.fromRGB(
			0,
			0,
			0
		)

	HealthText.TextStrokeTransparency =
		0

	HealthText.Font =
		Enum.Font.GothamBold

	HealthText.TextSize =
		Settings.HealthTextSize

	HealthText.TextXAlignment =
		Enum.TextXAlignment.Right

	HealthText.Parent =
		HealthBackground


	--==================================================
	-- DISTANCE TEXT
	--==================================================

	local DistanceText =
		Instance.new("TextLabel")

	DistanceText.Name =
		"Distance"

	DistanceText.BackgroundTransparency =
		1

	-- Тоже находится СЛЕВА от HP bar.

	DistanceText.AnchorPoint =
		Vector2.new(
			1,
			0
		)

	DistanceText.Position =
		UDim2.new(
			0,
			-Settings.HealthTextOffset,
			0.5,
			14
		)

	DistanceText.Size =
		UDim2.fromOffset(
			80,
			18
		)

	DistanceText.TextColor3 =
		Color3.fromRGB(
			220,
			220,
			220
		)

	DistanceText.TextStrokeColor3 =
		Color3.fromRGB(
			0,
			0,
			0
		)

	DistanceText.TextStrokeTransparency =
		0

	DistanceText.Font =
		Enum.Font.Gotham

	DistanceText.TextSize =
		Settings.DistanceSize

	DistanceText.TextXAlignment =
		Enum.TextXAlignment.Right

	DistanceText.Parent =
		HealthBackground


	--==================================================
	-- STORE
	--==================================================

	local Data = {

		Player = character,

		Container = Container,

		Corners = Corners,

		Name = Name,

		HealthBackground =
			HealthBackground,

		HealthBar =
			HealthBar,

		HealthText =
			HealthText,

		Distance =
			DistanceText
	}


	ESPObjects[character] =
		Data


	return Data
end


--==================================================
-- REMOVE ESP
--==================================================

local function RemoveESP(Player)

	local Data =
		ESPObjects[Player]

	if not Data then
		return
	end

	if Data.Container then
		Data.Container:Destroy()
	end

	ESPObjects[Player] = nil
end


--==================================================
-- GET ESP BOUNDS
--==================================================
--==================================================
-- GET ESP BOUNDS
--==================================================

local function GetBoundingBox(Character)

	--==================================================
	-- GET MODEL BOUNDING BOX
	--==================================================

	local BoxCFrame, BoxSize =
		Character:GetBoundingBox()

	if not BoxCFrame then
		return
	end


	--==================================================
	-- HALF SIZE
	--==================================================

	local HalfSize =
		BoxSize * 0.5


	--==================================================
	-- 8 CORNERS OF MODEL
	--==================================================

	local Corners = {

		Vector3.new(
			-HalfSize.X,
			-HalfSize.Y,
			-HalfSize.Z
		),

		Vector3.new(
			HalfSize.X,
			-HalfSize.Y,
			-HalfSize.Z
		),

		Vector3.new(
			-HalfSize.X,
			HalfSize.Y,
			-HalfSize.Z
		),

		Vector3.new(
			HalfSize.X,
			HalfSize.Y,
			-HalfSize.Z
		),

		Vector3.new(
			-HalfSize.X,
			-HalfSize.Y,
			HalfSize.Z
		),

		Vector3.new(
			HalfSize.X,
			-HalfSize.Y,
			HalfSize.Z
		),

		Vector3.new(
			-HalfSize.X,
			HalfSize.Y,
			HalfSize.Z
		),

		Vector3.new(
			HalfSize.X,
			HalfSize.Y,
			HalfSize.Z
		)
	}


	--==================================================
	-- PROJECT TO SCREEN
	--==================================================

	local MinX = math.huge
	local MinY = math.huge

	local MaxX = -math.huge
	local MaxY = -math.huge

	local HasVisiblePoint = false


	for _, Offset in ipairs(Corners) do

		local WorldPosition =
			BoxCFrame:PointToWorldSpace(
				Offset
			)


		local ScreenPosition =
			Camera:WorldToViewportPoint(
				WorldPosition
			)


		-- At least one point is in front
		if ScreenPosition.Z > 0 then

			HasVisiblePoint = true


			MinX =
				math.min(
					MinX,
					ScreenPosition.X
				)

			MinY =
				math.min(
					MinY,
					ScreenPosition.Y
				)

			MaxX =
				math.max(
					MaxX,
					ScreenPosition.X
				)

			MaxY =
				math.max(
					MaxY,
					ScreenPosition.Y
				)
		end
	end


	--==================================================
	-- NOTHING VISIBLE
	--==================================================

	if not HasVisiblePoint then
		return
	end


	--==================================================
	-- BASE SIZE
	--==================================================

	local BaseWidth =
		MaxX - MinX

	local BaseHeight =
		MaxY - MinY


	if BaseWidth <= 1 or
		BaseHeight <= 1 then

		return
	end


	--==================================================
	-- CENTER
	--==================================================

	local CenterX =
		(MinX + MaxX) * 0.5

	local CenterY =
		(MinY + MaxY) * 0.5


	--==================================================
	-- SCALE
	--==================================================

	local Width =
		BaseWidth *
		Settings.BoxScale

	local Height =
		BaseHeight *
		Settings.BoxScale


	--==================================================
	-- MAX HEIGHT
	--==================================================

	Height =
		math.min(
			Height,
			Settings.MaxBoxHeight
		)


	--==================================================
	-- MAX WIDTH
	--==================================================

	local MaxBoxWidth =
		Settings.MaxBoxHeight *
		Settings.BoxWidth


	Width =
		math.min(
			Width,
			MaxBoxWidth
		)


	--==================================================
	-- FINAL BOUNDS
	--==================================================

	local FinalMinX =
		CenterX -
		Width * 0.5

	local FinalMaxX =
		CenterX +
		Width * 0.5

	local FinalMinY =
		CenterY -
		Height * 0.5

	local FinalMaxY =
		CenterY +
		Height * 0.5


	return
		FinalMinX,
		FinalMinY,
		FinalMaxX,
		FinalMaxY
end


--==================================================
-- UPDATE ESP
--==================================================

local function UpdateESP(
	Character,
	Data
)

	if not Character then

		Data.Container.Visible =
			false

		return
	end


	local Humanoid =
		Character:FindFirstChildOfClass(
			"Humanoid"
		)

	local Root =
		Character:FindFirstChild(
			"HumanoidRootPart"
		)


	if not Humanoid or
		not Root or
		Humanoid.Health <= 0 then

		Data.Container.Visible =
			false

		return
	end


	--==================================================
	-- DISTANCE
	--==================================================

	local Distance =
		(
			Camera.CFrame.Position -
			Root.Position
		).Magnitude


	if Distance >
		Settings.MaxDistance then

		Data.Container.Visible =
			false

		return
	end


	--==================================================
	-- GET BOX
	--==================================================

	local MinX,
		MinY,
		MaxX,
		MaxY =
		GetBoundingBox(
			Character
		)


	if not MinX then

		Data.Container.Visible =
			false

		return
	end


	local Width =
		MaxX - MinX

	local Height =
		MaxY - MinY


	if Width <= 1 or
		Height <= 1 then

		Data.Container.Visible =
			false

		return
	end


	--==================================================
	-- CONTAINER
	--==================================================

	Data.Container.Visible =
		true

	Data.Container.Position =
		UDim2.fromOffset(
			MinX,
			MinY
		)

	Data.Container.Size =
		UDim2.fromOffset(
			Width,
			Height
		)


	--==================================================
	-- CORNER BOX
	--==================================================

	for _, Line in pairs(
		Data.Corners
		) do

		Line.BackgroundColor3 =
			Settings.BoxColor

		Line.Visible =
			Settings.Box
	end


	if Settings.Box then

		UpdateCornerBox(
			Data.Corners,
			Width,
			Height
		)
	end


	--==================================================
	-- DISPLAY NAME
	--==================================================

	Data.Name.Visible =
		Settings.DisplayName

	Data.Name.Text =
		Character.Name


	--==================================================
	-- HEALTH
	--==================================================

	Data.HealthBackground.Visible =
		Settings.HealthBar

	Data.HealthText.Visible =
		Settings.HealthText


	local MaxHealth =
		math.max(
			Humanoid.MaxHealth,
			1
		)


	local HealthPercent =
		math.clamp(
			Humanoid.Health /
			MaxHealth,
			0,
			1
		)


	--==================================================
	-- HEALTH BAR POSITION
	--==================================================

	Data.HealthBackground.Position =
		UDim2.fromOffset(
			-Settings.HealthBarOffset -
			Settings.HealthBarWidth,
			0
		)

	Data.HealthBackground.Size =
		UDim2.fromOffset(
			Settings.HealthBarWidth,
			Height
		)


	--==================================================
	-- HEALTH FILL
	--==================================================

	Data.HealthBar.Size =
		UDim2.new(
			1,
			0,
			HealthPercent,
			0
		)


	--==================================================
	-- HEALTH TEXT
	--==================================================

	Data.HealthText.Text =
		math.floor(
			Humanoid.Health
		)
		..
		" / "
		..
		math.floor(
			MaxHealth
		)


	--==================================================
	-- DISTANCE
	--==================================================

	Data.Distance.Visible =
		Settings.Distance

	Data.Distance.Text =
		"["
		..
		math.floor(
			Distance
		)
		..
		"m]"


	--==================================================
	-- HEALTH COLOR
	--==================================================

	if HealthPercent > 0.6 then

		Data.HealthBar.BackgroundColor3 =
			Settings.HealthHighColor

	elseif HealthPercent > 0.3 then

		Data.HealthBar.BackgroundColor3 =
			Settings.HealthMediumColor

	else

		Data.HealthBar.BackgroundColor3 =
			Settings.HealthLowColor
	end
end


--==================================================
-- INITIALIZE EXISTING PLAYERS
--==================================================

for _, entity in ipairs(
	CCS:GetTagged('Entity')
	) do

	if entity ~= LocalPlayer.Character then
		CreateESP(entity)
	end
end


--==================================================
-- PLAYER ADDED
--==================================================

CCS:GetInstanceAddedSignal('Entity'):Connect(function(entity)
	CreateESP(entity)
end)

CCS:GetInstanceRemovedSignal('Entity'):Connect(function(entity)
	RemoveESP(entity)
end)



--==================================================
-- PLAYER REMOVING
--==================================================



--==================================================
-- RENDER LOOP
--==================================================

RunService.RenderStepped:Connect(
	function()

		Camera =
			workspace.CurrentCamera

		for entity, Data in pairs(
			ESPObjects
			) do

			UpdateESP(
				entity,
				Data
			)

		end
	end
)

function espModule.setSetting(setting, v)
	Settings[setting] = v
end

return espModule
