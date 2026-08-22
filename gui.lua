--//==================================================
--// FPS MENU UI
--// Animated Dark Edition
--// UI ONLY
--//
--// Place in:
--// StarterPlayer > StarterPlayerScripts
--//==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer

--==================================================
-- COLORS
--==================================================
local md = {}
local Colors = {

	Main = Color3.fromRGB(14, 14, 15),
	Header = Color3.fromRGB(21, 21, 22),
	TabBar = Color3.fromRGB(12, 12, 13),

	Element = Color3.fromRGB(19, 19, 20),
	ElementHover = Color3.fromRGB(27, 27, 29),

	Input = Color3.fromRGB(17, 17, 18),

	Border = Color3.fromRGB(42, 42, 44),
	BorderLight = Color3.fromRGB(60, 60, 63),

	Text = Color3.fromRGB(235, 235, 237),
	SubText = Color3.fromRGB(155, 155, 158),
	Muted = Color3.fromRGB(105, 105, 108),

	Accent = Color3.fromRGB(96, 181, 246),
	AccentHover = Color3.fromRGB(120, 200, 255),

	ToggleOff = Color3.fromRGB(58, 58, 60),
	ToggleOffHover = Color3.fromRGB(72, 72, 75),

	ToggleKnob = Color3.fromRGB(245, 245, 245)
}

--==================================================
-- TWEEN INFO
--==================================================

local TweenFast = TweenInfo.new(
	0.12,
	Enum.EasingStyle.Quad,
	Enum.EasingDirection.Out
)

local TweenNormal = TweenInfo.new(
	0.2,
	Enum.EasingStyle.Quart,
	Enum.EasingDirection.Out
)

local TweenSmooth = TweenInfo.new(
	0.3,
	Enum.EasingStyle.Quart,
	Enum.EasingDirection.Out
)

local TweenSpring = TweenInfo.new(
	0.4,
	Enum.EasingStyle.Back,
	Enum.EasingDirection.Out
)

--==================================================
-- HELPER
--==================================================

local function CreateTween(Object, Info, Properties)

	local Tween = TweenService:Create(
		Object,
		Info,
		Properties
	)

	Tween:Play()

	return Tween
end


local function AddCorner(Object, Radius)

	local Corner = Instance.new("UICorner")

	Corner.CornerRadius = UDim.new(
		0,
		Radius
	)

	Corner.Parent = Object

	return Corner
end


local function AddStroke(Object, Color, Thickness)

	local Stroke = Instance.new("UIStroke")

	Stroke.Color = Color or Colors.Border
	Stroke.Thickness = Thickness or 1

	Stroke.Parent = Object

	return Stroke
end


local function AddPadding(
	Object,
	Left,
	Right,
	Top,
	Bottom
)

	local Padding = Instance.new("UIPadding")

	Padding.PaddingLeft = UDim.new(0, Left or 0)
	Padding.PaddingRight = UDim.new(0, Right or 0)
	Padding.PaddingTop = UDim.new(0, Top or 0)
	Padding.PaddingBottom = UDim.new(0, Bottom or 0)

	Padding.Parent = Object

	return Padding
end

--==================================================
-- SCREEN GUI
--==================================================

local ScreenGui = Instance.new("ScreenGui")

ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999
ScreenGui.Name = "FPSMenu"
ScreenGui.ResetOnSpawn = false
--ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ScreenGui.Parent =
	game.CoreGui

--==================================================
-- BACKGROUND EFFECT
--==================================================

local Background = Instance.new("Frame")

Background.Name = "BackgroundEffect"

Background.Size =
	UDim2.fromScale(1, 1)

Background.Position =
	UDim2.fromScale(0, 0)

Background.BackgroundColor3 =
	Color3.fromRGB(3, 3, 4)

Background.BackgroundTransparency = 1

Background.BorderSizePixel = 0

Background.Visible = false

Background.ZIndex = 1

Background.Parent = ScreenGui

--==================================================
-- DARK OVERLAY
--==================================================

local BackgroundOverlay = Instance.new("Frame")

BackgroundOverlay.Name = "Overlay"

BackgroundOverlay.Size =
	UDim2.fromScale(1, 1)

BackgroundOverlay.Position =
	UDim2.fromScale(0, 0)

BackgroundOverlay.BackgroundColor3 =
	Color3.fromRGB(0, 0, 0)

BackgroundOverlay.BackgroundTransparency = 1

BackgroundOverlay.BorderSizePixel = 0

BackgroundOverlay.ZIndex = 1

BackgroundOverlay.Parent = Background

--==================================================
-- LINES CONTAINER
--==================================================

local LinesContainer = Instance.new("Frame")

LinesContainer.Name = "Lines"

LinesContainer.Size =
	UDim2.fromScale(1, 1)

LinesContainer.Position =
	UDim2.fromScale(0, 0)

LinesContainer.BackgroundTransparency = 1
LinesContainer.BorderSizePixel = 0

LinesContainer.ZIndex = 2

LinesContainer.Parent = Background


local BackgroundLines = {}

local LINE_COUNT = 28

local BackgroundActive = false

--==================================================
-- CREATE BACKGROUND LINE
--==================================================

local function CreateBackgroundLine()

	local Line = Instance.new("Frame")

	Line.Name = "Line"

	Line.AnchorPoint =
		Vector2.new(0.5, 0.5)

	Line.Size = UDim2.new(
		0,
		math.random(1, 2),
		0,
		math.random(70, 180)
	)

	Line.Position = UDim2.new(
		math.random(),
		0,
		-math.random(10, 100) / 100,
		0
	)

	Line.Rotation =
		math.random(-12, 12)

	Line.BackgroundColor3 =
		Colors.Accent

	Line.BackgroundTransparency =
		math.random(70, 88) / 100

	Line.BorderSizePixel = 0

	Line.ZIndex = 2

	Line.Parent =
		LinesContainer

	table.insert(
		BackgroundLines,
		Line
	)

	return Line
end


for i = 1, LINE_COUNT do
	CreateBackgroundLine()
end

--==================================================
-- ANIMATE LINE
--==================================================

local function AnimateLine(Line)

	if not BackgroundActive then
		return
	end

	Line.Position = UDim2.new(
		math.random(),
		0,
		-math.random(10, 100) / 100,
		0
	)

	Line.Size = UDim2.new(
		0,
		math.random(1, 2),
		0,
		math.random(70, 180)
	)

	Line.Rotation =
		math.random(-12, 12)

	Line.BackgroundTransparency =
		math.random(70, 88) / 100


	local Duration =
		math.random(45, 90) / 10


	local TargetX =
		Line.Position.X.Scale
		+ math.random(-8, 8) / 100


	local Animation =
		TweenService:Create(

			Line,

			TweenInfo.new(
				Duration,
				Enum.EasingStyle.Linear,
				Enum.EasingDirection.InOut
			),

			{
				Position = UDim2.new(
					TargetX,
					0,
					1.15,
					0
				)
			}
		)


	Animation.Completed:Connect(function()

		if BackgroundActive then
			AnimateLine(Line)
		end

	end)


	Animation:Play()
end

--==================================================
-- START BACKGROUND
--==================================================

local function StartBackground()

	if BackgroundActive then
		return
	end

	BackgroundActive = true

	Background.Visible = true

	BackgroundOverlay.BackgroundTransparency = 1


	CreateTween(
		BackgroundOverlay,
		TweenSmooth,
		{
			BackgroundTransparency = 0.78
		}
	)


	for _, Line in ipairs(BackgroundLines) do

		task.delay(
			math.random(0, 100) / 100,
			function()

				if BackgroundActive then
					AnimateLine(Line)
				end

			end
		)

	end
end

--==================================================
-- STOP BACKGROUND
--==================================================

local function StopBackground()

	if not BackgroundActive then
		return
	end

	BackgroundActive = false


	CreateTween(
		BackgroundOverlay,
		TweenSmooth,
		{
			BackgroundTransparency = 1
		}
	)


	for _, Line in ipairs(BackgroundLines) do

		CreateTween(
			Line,
			TweenSmooth,
			{
				BackgroundTransparency = 1
			}
		)

	end


	task.delay(
		0.35,
		function()

			if not BackgroundActive then
				Background.Visible = false
			end

		end
	)
end

--==================================================
-- MAIN FRAME
--==================================================

local MainFrame = Instance.new("Frame")

MainFrame.Name = "MainFrame"

MainFrame.Size = UDim2.new(
	0,
	400,
	0,
	520
)

local OriginalPosition = UDim2.new(
	0.5,
	-200,
	0.5,
	-260
)

MainFrame.Position =
	OriginalPosition

MainFrame.BackgroundColor3 =
	Colors.Main

MainFrame.BorderSizePixel = 0

MainFrame.Visible = false

MainFrame.ZIndex = 10

MainFrame.Parent =
	ScreenGui


AddCorner(
	MainFrame,
	8
)


AddStroke(
	MainFrame,
	Colors.Border,
	1
)

--==================================================
-- HEADER
--==================================================

local Header = Instance.new("Frame")

Header.Name = "Header"

Header.Size = UDim2.new(
	1,
	0,
	0,
	58
)

Header.BackgroundColor3 =
	Colors.Header

Header.BorderSizePixel = 0

Header.ZIndex = 11

Header.Parent =
	MainFrame


AddCorner(
	Header,
	8
)


local HeaderBottom = Instance.new("Frame")

HeaderBottom.Size =
	UDim2.new(
		1,
		0,
		0,
		12
	)

HeaderBottom.Position =
	UDim2.new(
		0,
		0,
		1,
		-12
	)

HeaderBottom.BackgroundColor3 =
	Colors.Header

HeaderBottom.BorderSizePixel = 0

HeaderBottom.ZIndex = 11

HeaderBottom.Parent =
	Header


local HeaderLine = Instance.new("Frame")

HeaderLine.Size =
	UDim2.new(
		1,
		0,
		0,
		1
	)

HeaderLine.Position =
	UDim2.new(
		0,
		0,
		1,
		-1
	)

HeaderLine.BackgroundColor3 =
	Colors.Border

HeaderLine.BorderSizePixel = 0

HeaderLine.ZIndex = 12

HeaderLine.Parent =
	Header


local Title = Instance.new("TextLabel")

Title.Name = "Title"

Title.Text = "⚙  Cheat Menu"

Title.TextSize = 18

Title.Font =
	Enum.Font.GothamBold

Title.TextColor3 =
	Colors.Text

Title.BackgroundTransparency = 1

Title.Size =
	UDim2.new(
		1,
		-30,
		1,
		0
	)

Title.Position =
	UDim2.new(
		0,
		16,
		0,
		0
	)

Title.TextXAlignment =
	Enum.TextXAlignment.Left

Title.ZIndex = 13

Title.Parent =
	Header

--==================================================
-- DRAG SYSTEM
--==================================================

local Dragging = false

local DragStart

local StartPosition


Header.InputBegan:Connect(function(Input)

	if Input.UserInputType ==
		Enum.UserInputType.MouseButton1 then

		Dragging = true

		DragStart =
			Input.Position

		StartPosition =
			MainFrame.Position

	end

end)


Header.InputEnded:Connect(function(Input)

	if Input.UserInputType ==
		Enum.UserInputType.MouseButton1 then

		Dragging = false

	end

end)


UserInputService.InputChanged:Connect(function(Input)

	if not Dragging then
		return
	end

	if Input.UserInputType ~=
		Enum.UserInputType.MouseMovement then

		return
	end


	local Delta =
		Input.Position - DragStart


	local TargetPosition = UDim2.new(

		StartPosition.X.Scale,

		StartPosition.X.Offset
			+ Delta.X,

		StartPosition.Y.Scale,

		StartPosition.Y.Offset
			+ Delta.Y
	)


	CreateTween(
		MainFrame,

		TweenInfo.new(
			0.08,
			Enum.EasingStyle.Quart,
			Enum.EasingDirection.Out
		),

		{
			Position =
				TargetPosition
		}
	)

end)

--==================================================
-- TABS
--==================================================

local TabContainer = Instance.new("Frame")

TabContainer.Name =
	"TabContainer"

TabContainer.Size =
	UDim2.new(
		1,
		-2,
		0,
		44
	)

TabContainer.Position =
	UDim2.new(
		0,
		1,
		0,
		58
	)

TabContainer.BackgroundColor3 =
	Colors.TabBar

TabContainer.BorderSizePixel = 0

TabContainer.ZIndex = 11

TabContainer.Parent =
	MainFrame


local TabLayout = Instance.new("UIListLayout")

TabLayout.FillDirection =
	Enum.FillDirection.Horizontal

TabLayout.HorizontalAlignment =
	Enum.HorizontalAlignment.Center

TabLayout.VerticalAlignment =
	Enum.VerticalAlignment.Center

TabLayout.SortOrder =
	Enum.SortOrder.LayoutOrder

TabLayout.Padding =
	UDim.new(0, 1)

TabLayout.Parent =
	TabContainer


local function CreateTab(Name, Order)

	local Tab = Instance.new("TextButton")

	Tab.Name =
		Name .. "Tab"

	Tab.Text =
		string.upper(Name)

	Tab.TextSize = 13

	Tab.Font =
		Enum.Font.GothamBold

	Tab.TextColor3 =
		Colors.SubText

	Tab.BackgroundColor3 =
		Colors.TabBar

	Tab.BorderSizePixel = 0

	Tab.Size =
		UDim2.new(
			1 / 3,
			-1,
			1,
			0
		)

	Tab.LayoutOrder =
		Order

	Tab.AutoButtonColor = false

	Tab.ZIndex = 12

	Tab.Parent =
		TabContainer


	AddCorner(
		Tab,
		5
	)


	Tab.MouseEnter:Connect(function()

		if Tab.BackgroundColor3
			~= Colors.Element then

			CreateTween(
				Tab,
				TweenFast,
				{
					BackgroundColor3 =
						Colors.ElementHover,

					TextColor3 =
						Colors.Text
				}
			)

		end

	end)


	Tab.MouseLeave:Connect(function()

		if Tab.BackgroundColor3
			~= Colors.Element then

			CreateTween(
				Tab,
				TweenFast,
				{
					BackgroundColor3 =
						Colors.TabBar,

					TextColor3 =
						Colors.SubText
				}
			)

		end

	end)


	Tab.MouseButton1Down:Connect(function()

		CreateTween(
			Tab,
			TweenFast,
			{
				Size = UDim2.new(
					1 / 3,
					-5,
					1,
					-3
				)
			}
		)

	end)


	Tab.MouseButton1Up:Connect(function()

		CreateTween(
			Tab,
			TweenFast,
			{
				Size = UDim2.new(
					1 / 3,
					-1,
					1,
					0
				)
			}
		)

	end)


	return Tab
end


local PVPTab =
	CreateTab("PVP", 1)

local VisualsTab =
	CreateTab("Visuals", 2)

local MiscTab =
	CreateTab("Misc", 3)

--==================================================
-- CONTENT CONTAINER
--==================================================

local ContentFrame = Instance.new("Frame")

ContentFrame.Name =
	"ContentFrame"

ContentFrame.Size =
	UDim2.new(
		1,
		-2,
		1,
		-102
	)

ContentFrame.Position =
	UDim2.new(
		0,
		1,
		0,
		102
	)

ContentFrame.BackgroundColor3 =
	Colors.Main

ContentFrame.BorderSizePixel = 0

ContentFrame.ZIndex = 11

ContentFrame.Parent =
	MainFrame

--==================================================
-- TAB CONTENT FRAMES
--==================================================

local PVPContent = Instance.new("ScrollingFrame")

PVPContent.Name =
	"PVPContent"

PVPContent.Size =
	UDim2.fromScale(1, 1)

PVPContent.Position =
	UDim2.fromScale(0, 0)

PVPContent.BackgroundColor3 =
	Colors.Main

PVPContent.BorderSizePixel = 0

PVPContent.ScrollBarThickness = 4

PVPContent.ScrollBarImageColor3 =
	Colors.BorderLight

PVPContent.CanvasSize =
	UDim2.new(0, 0, 0, 0)

PVPContent.AutomaticCanvasSize =
	Enum.AutomaticSize.Y

PVPContent.ScrollingDirection =
	Enum.ScrollingDirection.Y

PVPContent.Visible = true

PVPContent.ZIndex = 11

PVPContent.Parent =
	ContentFrame


local VisualsContent = Instance.new("ScrollingFrame")

VisualsContent.Name =
	"VisualsContent"

VisualsContent.Size =
	UDim2.fromScale(1, 1)

VisualsContent.Position =
	UDim2.fromScale(0, 0)

VisualsContent.BackgroundColor3 =
	Colors.Main

VisualsContent.BorderSizePixel = 0

VisualsContent.ScrollBarThickness = 4

VisualsContent.ScrollBarImageColor3 =
	Colors.BorderLight

VisualsContent.CanvasSize =
	UDim2.new(0, 0, 0, 0)

VisualsContent.AutomaticCanvasSize =
	Enum.AutomaticSize.Y

VisualsContent.ScrollingDirection =
	Enum.ScrollingDirection.Y

VisualsContent.Visible = false

VisualsContent.ZIndex = 11

VisualsContent.Parent =
	ContentFrame


local MiscContent = Instance.new("ScrollingFrame")

MiscContent.Name =
	"MiscContent"

MiscContent.Size =
	UDim2.fromScale(1, 1)

MiscContent.Position =
	UDim2.fromScale(0, 0)

MiscContent.BackgroundColor3 =
	Colors.Main

MiscContent.BorderSizePixel = 0

MiscContent.ScrollBarThickness = 4

MiscContent.ScrollBarImageColor3 =
	Colors.BorderLight

MiscContent.CanvasSize =
	UDim2.new(0, 0, 0, 0)

MiscContent.AutomaticCanvasSize =
	Enum.AutomaticSize.Y

MiscContent.ScrollingDirection =
	Enum.ScrollingDirection.Y

MiscContent.Visible = false

MiscContent.ZIndex = 11

MiscContent.Parent =
	ContentFrame

--==================================================
-- CONTENT SETUP
--==================================================

local function SetupContentFrame(Frame)

	AddPadding(
		Frame,
		16,
		16,
		16,
		16
	)


	local Layout = Instance.new("UIListLayout")

	Layout.Padding =
		UDim.new(0, 8)

	Layout.SortOrder =
		Enum.SortOrder.LayoutOrder

	Layout.Parent =
		Frame

end


SetupContentFrame(PVPContent)
SetupContentFrame(VisualsContent)
SetupContentFrame(MiscContent)

--==================================================
-- SECTION TITLE
--==================================================

local function CreateSectionTitle(
	Parent,
	Text
)

	local Section =
		Instance.new("TextLabel")

	Section.Name =
		"SectionTitle"

	Section.Text =
		string.upper(Text)

	Section.TextSize = 11

	Section.Font =
		Enum.Font.GothamBold

	Section.TextColor3 =
		Colors.Muted

	Section.BackgroundTransparency = 1

	Section.Size =
		UDim2.new(
			1,
			0,
			0,
			24
		)

	Section.TextXAlignment =
		Enum.TextXAlignment.Left

	Section.ZIndex = 12

	Section.Parent =
		Parent

	return Section
end

--==================================================
-- DIVIDER
--==================================================

local function CreateDivider(Parent)

	local Divider =
		Instance.new("Frame")

	Divider.Name =
		"Divider"

	Divider.Size =
		UDim2.new(
			1,
			0,
			0,
			1
		)

	Divider.BackgroundColor3 =
		Colors.Border

	Divider.BorderSizePixel = 0

	Divider.ZIndex = 12

	Divider.Parent =
		Parent

	return Divider
end

--==================================================
-- TOGGLE
--==================================================

local function CreateToggle(
	Parent,
	Label,
	DefaultValue,
	Propertie
)

	local Container =
		Instance.new("Frame")

	Container:SetAttribute(
		"DefaultValue",
		DefaultValue
	)

	if Propertie then

		Container:SetAttribute(
			"Propertie",
			Propertie
		)

	end

	Container.Name =
		Label .. "Container"

	Container.Size =
		UDim2.new(
			1,
			0,
			0,
			48
		)

	Container.BackgroundTransparency = 1

	Container.BorderSizePixel = 0

	Container.ZIndex = 12

	Container.Parent =
		Parent


	local LabelText =
		Instance.new("TextLabel")

	LabelText.Name = "Label"

	LabelText.Text = Label

	LabelText.TextSize = 13

	LabelText.Font =
		Enum.Font.GothamMedium

	LabelText.TextColor3 =
		Colors.Text

	LabelText.BackgroundTransparency = 1

	LabelText.Size =
		UDim2.new(
			1,
			-80,
			1,
			0
		)

	LabelText.TextXAlignment =
		Enum.TextXAlignment.Left

	LabelText.ZIndex = 13

	LabelText.Parent =
		Container


	--==================================================
	-- TOGGLE BUTTON
	--==================================================

	local Toggle =
		Instance.new("TextButton")

	Toggle.Name =
		Label .. "Toggle"

	Toggle.Text = ""

	Toggle.AutoButtonColor = false

	Toggle.Size =
		UDim2.new(
			0,
			40,
			0,
			22
		)

	Toggle.Position =
		UDim2.new(
			1,
			-40,
			0.5,
			-11
		)

	Toggle.BorderSizePixel = 0

	Toggle.BackgroundColor3 =
		DefaultValue
		and Colors.Accent
		or Colors.ToggleOff

	Toggle.ZIndex = 13

	Toggle.Parent =
		Container


	AddCorner(
		Toggle,
		20
	)


	--==================================================
	-- KNOB
	--==================================================

	local Knob =
		Instance.new("Frame")

	Knob.Name = "Knob"

	Knob.Size =
		UDim2.new(
			0,
			18,
			0,
			18
		)

	Knob.Position =

		DefaultValue
		and UDim2.new(
			1,
			-20,
			0.5,
			-9
		)

		or UDim2.new(
			0,
			2,
			0.5,
			-9
		)

	Knob.BackgroundColor3 =
		Colors.ToggleKnob

	Knob.BorderSizePixel = 0

	Knob.ZIndex = 14

	Knob.Parent =
		Toggle


	AddCorner(
		Knob,
		20
	)


	local Enabled =
		DefaultValue


	--==================================================
	-- HOVER
	--==================================================

	Toggle.MouseEnter:Connect(function()

		CreateTween(
			Toggle,
			TweenFast,
			{
				BackgroundColor3 =
					Enabled
					and Colors.AccentHover
					or Colors.ToggleOffHover
			}
		)

	end)


	Toggle.MouseLeave:Connect(function()

		CreateTween(
			Toggle,
			TweenFast,
			{
				BackgroundColor3 =
					Enabled
					and Colors.Accent
					or Colors.ToggleOff
			}
		)

	end)


	--==================================================
	-- CLICK
	--==================================================

	Toggle.MouseButton1Click:Connect(function()

		Enabled =
			not Enabled


		local TargetColor =

			Enabled
			and Colors.Accent
			or Colors.ToggleOff


		local TargetPosition =

			Enabled

			and UDim2.new(
				1,
				-20,
				0.5,
				-9
			)

			or UDim2.new(
				0,
				2,
				0.5,
				-9
			)


		CreateTween(
			Toggle,
			TweenNormal,
			{
				BackgroundColor3 =
					TargetColor
			}
		)


		CreateTween(
			Knob,
			TweenSpring,
			{
				Position =
					TargetPosition
			}
		)

	end)


	--==================================================
	-- PRESS
	--==================================================

	Toggle.MouseButton1Down:Connect(function()

		CreateTween(
			Toggle,
			TweenFast,
			{
				Size = UDim2.new(
					0,
					37,
					0,
					21
				)
			}
		)

	end)


	Toggle.MouseButton1Up:Connect(function()

		CreateTween(
			Toggle,
			TweenFast,
			{
				Size = UDim2.new(
					0,
					40,
					0,
					22
				)
			}
		)

	end)


	return Toggle
end

--==================================================
-- NUMBER INPUT
--==================================================

local function CreateNumberInput(
	Parent,
	Label,
	DefaultValue
)

	local Container =
		Instance.new("Frame")

	Container.Name =
		Label .. "Container"

	Container.Size =
		UDim2.new(
			1,
			0,
			0,
			76
		)

	Container.BackgroundTransparency = 1

	Container.BorderSizePixel = 0

	Container.ZIndex = 12

	Container.Parent =
		Parent


	local LabelText =
		Instance.new("TextLabel")

	LabelText.Name = "Label"

	LabelText.Text = Label

	LabelText.TextSize = 13

	LabelText.Font =
		Enum.Font.GothamMedium

	LabelText.TextColor3 =
		Colors.Text

	LabelText.BackgroundTransparency = 1

	LabelText.Size =
		UDim2.new(
			1,
			0,
			0,
			22
		)

	LabelText.TextXAlignment =
		Enum.TextXAlignment.Left

	LabelText.ZIndex = 13

	LabelText.Parent =
		Container


	local Input =
		Instance.new("TextBox")

	Input.Name = "Input"

	Input.Text =
		tostring(DefaultValue)

	Input.TextSize = 13

	Input.Font =
		Enum.Font.Gotham

	Input.TextColor3 =
		Colors.Text

	Input.BackgroundColor3 =
		Colors.Input

	Input.BorderSizePixel = 0

	Input.ClearTextOnFocus = false

	Input.Size =
		UDim2.new(
			1,
			0,
			0,
			36
		)

	Input.Position =
		UDim2.new(
			0,
			0,
			0,
			28
		)

	Input.TextXAlignment =
		Enum.TextXAlignment.Left

	Input.ZIndex = 13

	Input.Parent =
		Container


	AddCorner(
		Input,
		6
	)


	local InputStroke =
		AddStroke(
			Input,
			Colors.Border,
			1
		)


	AddPadding(
		Input,
		12,
		12,
		0,
		0
	)


	Input.Focused:Connect(function()

		CreateTween(
			InputStroke,
			TweenNormal,
			{
				Color =
					Colors.Accent
			}
		)

	end)


	Input.FocusLost:Connect(function()

		CreateTween(
			InputStroke,
			TweenNormal,
			{
				Color =
					Colors.Border
			}
		)

	end)


	return Input
end

--==================================================
-- DROPDOWN
--==================================================

local function CreateDropdown(
	Parent,
	Label,
	Options,
	DefaultIndex
)

	local Container =
		Instance.new("Frame")

	Container.Name =
		Label .. "Container"

	Container.Size =
		UDim2.new(
			1,
			0,
			0,
			76
		)

	Container.BackgroundTransparency = 1

	Container.BorderSizePixel = 0

	Container.ClipsDescendants = false

	Container.ZIndex = 20

	Container.Parent =
		Parent


	--==================================================
	-- LABEL
	--==================================================

	local LabelText =
		Instance.new("TextLabel")

	LabelText.Name = "Label"

	LabelText.Text = Label

	LabelText.TextSize = 13

	LabelText.Font =
		Enum.Font.GothamMedium

	LabelText.TextColor3 =
		Colors.Text

	LabelText.BackgroundTransparency = 1

	LabelText.Size =
		UDim2.new(
			1,
			0,
			0,
			22
		)

	LabelText.TextXAlignment =
		Enum.TextXAlignment.Left

	LabelText.ZIndex = 21

	LabelText.Parent =
		Container


	--==================================================
	-- DROPDOWN BUTTON
	--==================================================

	local Dropdown =
		Instance.new("TextButton")

	Dropdown.Name =
		Label .. "Dropdown"

	Dropdown.Text =
		Options[DefaultIndex]

	Dropdown.TextSize = 13

	Dropdown.Font =
		Enum.Font.Gotham

	Dropdown.TextColor3 =
		Colors.Text

	Dropdown.TextXAlignment =
		Enum.TextXAlignment.Left

	Dropdown.AutoButtonColor = false

	Dropdown.BackgroundColor3 =
		Colors.Input

	Dropdown.BorderSizePixel = 0

	Dropdown.Size =
		UDim2.new(
			1,
			0,
			0,
			36
		)

	Dropdown.Position =
		UDim2.new(
			0,
			0,
			0,
			28
		)

	Dropdown.ZIndex = 22

	Dropdown.Parent =
		Container


	AddCorner(
		Dropdown,
		6
	)


	local DropdownStroke =
		AddStroke(
			Dropdown,
			Colors.Border,
			1
		)


	AddPadding(
		Dropdown,
		12,
		36,
		0,
		0
	)


	--==================================================
	-- ARROW
	--==================================================

	local Arrow =
		Instance.new("TextLabel")

	Arrow.Name = "Arrow"

	Arrow.Text = "⌄"

	Arrow.TextSize = 18

	Arrow.Font =
		Enum.Font.Gotham

	Arrow.TextColor3 =
		Colors.SubText

	Arrow.BackgroundTransparency = 1

	Arrow.Size =
		UDim2.new(
			0,
			25,
			1,
			0
		)

	Arrow.Position =
		UDim2.new(
			1,
			-30,
			0,
			0
		)

	Arrow.ZIndex = 23

	Arrow.Parent =
		Dropdown


	--==================================================
	-- STATE
	--==================================================

	local IsOpen = false

	local OptionButtons = {}

	local ClosedHeight = 76

	local OpenedHeight =
		76 + (#Options * 34)


	--==================================================
	-- CLOSE DROPDOWN
	--==================================================

	local function CloseDropdown()

		if not IsOpen then
			return
		end

		IsOpen = false


		for _, Button in ipairs(OptionButtons) do

			CreateTween(
				Button,
				TweenFast,
				{
					BackgroundTransparency = 1,
					TextTransparency = 1
				}
			)

		end


		CreateTween(
			Container,
			TweenSmooth,
			{
				Size = UDim2.new(
					1,
					0,
					0,
					ClosedHeight
				)
			}
		)


		CreateTween(
			Arrow,
			TweenSmooth,
			{
				Rotation = 0
			}
		)


		CreateTween(
			DropdownStroke,
			TweenNormal,
			{
				Color =
					Colors.Border
			}
		)


		task.delay(
			0.25,
			function()

				if not IsOpen then

					for _, Button in ipairs(OptionButtons) do

						Button:Destroy()

					end

					table.clear(
						OptionButtons
					)

				end

			end
		)

	end


	--==================================================
	-- OPEN DROPDOWN
	--==================================================

	local function OpenDropdown()

		if IsOpen then
			return
		end

		IsOpen = true


		CreateTween(
			Container,
			TweenSmooth,
			{
				Size = UDim2.new(
					1,
					0,
					0,
					OpenedHeight
				)
			}
		)


		CreateTween(
			Arrow,
			TweenSmooth,
			{
				Rotation = 180
			}
		)


		CreateTween(
			DropdownStroke,
			TweenNormal,
			{
				Color =
					Colors.Accent
			}
		)


		for Index, Option in ipairs(Options) do

			local Button =
				Instance.new("TextButton")

			Button:SetAttribute(
				"part",
				Option
			)

			Button.Name =
				"Option" .. Index

			Button.Text =
				Option

			Button.TextSize = 12

			Button.Font =
				Enum.Font.Gotham

			Button.TextColor3 =
				Colors.Text

			Button.TextTransparency = 1

			Button.TextXAlignment =
				Enum.TextXAlignment.Left

			Button.AutoButtonColor = false

			Button.BackgroundColor3 =
				Colors.Element

			Button.BackgroundTransparency = 1

			Button.BorderSizePixel = 0

			Button.Size =
				UDim2.new(
					1,
					0,
					0,
					32
				)

			Button.Position =
				UDim2.new(
					0,
					0,
					0,
					68 + ((Index - 1) * 34)
				)

			Button.ZIndex = 24

			Button.Parent =
				Container


			AddCorner(
				Button,
				5
			)


			AddStroke(
				Button,
				Colors.Border,
				1
			)


			AddPadding(
				Button,
				12,
				8,
				0,
				0
			)


			table.insert(
				OptionButtons,
				Button
			)


			task.delay(
				(Index - 1) * 0.025,
				function()

					if not IsOpen then
						return
					end


					CreateTween(
						Button,
						TweenNormal,
						{
							BackgroundTransparency = 0,
							TextTransparency = 0
						}
					)

				end
			)


			--==================================================
			-- HOVER
			--==================================================

			Button.MouseEnter:Connect(function()

				CreateTween(
					Button,
					TweenFast,
					{
						BackgroundColor3 =
							Colors.ElementHover
					}
				)

			end)


			Button.MouseLeave:Connect(function()

				CreateTween(
					Button,
					TweenFast,
					{
						BackgroundColor3 =
							Colors.Element
					}
				)

			end)


			--==================================================
			-- CLICK
			--==================================================

			Button.MouseButton1Click:Connect(function()

				Dropdown.Text =
					Option

				CloseDropdown()

			end)


			--==================================================
			-- PRESS
			--==================================================

			Button.MouseButton1Down:Connect(function()

				CreateTween(
					Button,
					TweenFast,
					{
						Size = UDim2.new(
							1,
							-4,
							0,
							30
						)
					}
				)

			end)


			Button.MouseButton1Up:Connect(function()

				CreateTween(
					Button,
					TweenFast,
					{
						Size = UDim2.new(
							1,
							0,
							0,
							32
						)
					}
				)

			end)

		end

	end


	--==================================================
	-- DROPDOWN HOVER
	--==================================================

	Dropdown.MouseEnter:Connect(function()

		if not IsOpen then

			CreateTween(
				DropdownStroke,
				TweenFast,
				{
					Color =
						Colors.BorderLight
				}
			)

		end

	end)


	Dropdown.MouseLeave:Connect(function()

		if not IsOpen then

			CreateTween(
				DropdownStroke,
				TweenFast,
				{
					Color =
						Colors.Border
				}
			)

		end

	end)


	Dropdown.MouseButton1Click:Connect(function()

		if IsOpen then
			CloseDropdown()
		else
			OpenDropdown()
		end

	end)


	return Dropdown
end

--==================================================
-- BUILD PVP
--==================================================

local function BuildPVP()

	CreateSectionTitle(
		PVPContent,
		"Combat Settings"
	)


	CreateToggle(
		PVPContent,
		"Silent Aim",
		false
	)


	CreateDivider(
		PVPContent
	)


	CreateDropdown(
		PVPContent,
		"Silent Target",

		{
			"Head",
			"UpperTorso",
			"Closest"
		},

		2
	)


	CreateDivider(
		PVPContent
	)


	CreateNumberInput(
		PVPContent,
		"Silent FOV",
		300
	)


	CreateToggle(
		PVPContent,
		"Show FOV Circle",
		true,
		"ShowFOV"
	)

end

--==================================================
-- BUILD VISUALS
--==================================================

local function BuildVisuals()

	CreateSectionTitle(
		VisualsContent,
		"Visual Settings"
	)


	CreateToggle(
		VisualsContent,
		"ESP Boxes",
		false
	)


	CreateToggle(
		VisualsContent,
		"Health Bars",
		false
	)


	CreateToggle(
		VisualsContent,
		"Display Names",
		false
	)


	CreateToggle(
		VisualsContent,
		"Show Distance",
		false
	)

end

--==================================================
-- BUILD MISC
--==================================================

local function BuildMisc()

	CreateSectionTitle(
		MiscContent,
		"Movement Settings"
	)


	CreateNumberInput(
		MiscContent,
		"Speed",
		16
	)


	CreateNumberInput(
		MiscContent,
		"Jump Power",
		50
	)

end

--==================================================
-- CREATE ALL TABS ONCE
--==================================================

BuildPVP()
BuildVisuals()
BuildMisc()

--==================================================
-- TAB STATE
--==================================================

local CurrentTab = nil


local function SetActiveTab(
	ActiveTab
)

	--==================================================
	-- TAB BUTTON VISUALS
	--==================================================

	local Tabs = {

		PVPTab,
		VisualsTab,
		MiscTab

	}


	for _, Tab in ipairs(Tabs) do

		if Tab == ActiveTab then

			CreateTween(
				Tab,
				TweenNormal,
				{
					TextColor3 =
						Colors.Text,

					BackgroundColor3 =
						Colors.Element
				}
			)

		else

			CreateTween(
				Tab,
				TweenNormal,
				{
					TextColor3 =
						Colors.SubText,

					BackgroundColor3 =
						Colors.TabBar
				}
			)

		end

	end


	--==================================================
	-- CHANGE ONLY VISIBLE
	--==================================================

	PVPContent.Visible =
		ActiveTab == PVPTab

	VisualsContent.Visible =
		ActiveTab == VisualsTab

	MiscContent.Visible =
		ActiveTab == MiscTab


	CurrentTab =
		ActiveTab

end

--==================================================
-- TAB BUTTONS
--==================================================

PVPTab.MouseButton1Click:Connect(function()

	SetActiveTab(
		PVPTab
	)

end)


VisualsTab.MouseButton1Click:Connect(function()

	SetActiveTab(
		VisualsTab
	)

end)


MiscTab.MouseButton1Click:Connect(function()

	SetActiveTab(
		MiscTab
	)

end)

--==================================================
-- MENU OPEN / CLOSE
--==================================================

local MenuOpen = false


local function OpenMenu()

	if MenuOpen then
		return
	end

	MenuOpen = true


	--==================================================
	-- START BACKGROUND
	--==================================================

	StartBackground()


	--==================================================
	-- INITIAL POSITION
	--==================================================

	MainFrame.Visible = true

	MainFrame.Position = UDim2.new(

		OriginalPosition.X.Scale,

		OriginalPosition.X.Offset,

		OriginalPosition.Y.Scale,

		OriginalPosition.Y.Offset + 18

	)

	MainFrame.BackgroundTransparency = 1


	--==================================================
	-- OPEN ANIMATION
	--==================================================

	CreateTween(
		MainFrame,
		TweenSpring,
		{
			Position =
				OriginalPosition,

			BackgroundTransparency = 0
		}
	)

end


local function CloseMenu()

	if not MenuOpen then
		return
	end

	MenuOpen = false


	StopBackground()


	local Animation =
		TweenService:Create(

			MainFrame,

			TweenNormal,

			{
				Position = UDim2.new(

					OriginalPosition.X.Scale,

					OriginalPosition.X.Offset,

					OriginalPosition.Y.Scale,

					OriginalPosition.Y.Offset + 18

				),

				BackgroundTransparency = 1
			}
		)


	Animation:Play()


	Animation.Completed:Connect(function()

		if not MenuOpen then

			MainFrame.Visible = false

		end

	end)

end

--==================================================
-- INSERT KEY
--==================================================

UserInputService.InputBegan:Connect(function(
	Input,
	GameProcessed
)

	if GameProcessed then
		return
	end


	if Input.KeyCode ==
		Enum.KeyCode.Insert then

		if MenuOpen then

			CloseMenu()

		else

			OpenMenu()

		end

	end

end)

--==================================================
-- INITIALIZE
--==================================================

SetActiveTab(
	PVPTab
)

print(
	"✓ Animated FPS UI loaded"
)

md.get = function()
	return ScreenGui
end

return md
