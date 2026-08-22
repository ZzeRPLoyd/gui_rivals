local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer

-- Загружаем модули в фоне
	pcall(function()
		getgenv().library = {}
		--getgenv().library.silentModule = loadstring(game:HttpGet('https://raw.githubusercontent.com/ZzeRPLoyd/gui_rivals/refs/heads/main/silent.lua', true))()
		getgenv().library.espModule = loadstring(game:HttpGet('https://raw.githubusercontent.com/ZzeRPLoyd/gui_rivals/refs/heads/main/esp.lua', true))()	
print('esp injcted')
task.wait(1)
    getgenv().library.silentModule = loadstring(game:HttpGet('https://raw.githubusercontent.com/ZzeRPLoyd/gui_rivals/refs/heads/main/silent.lua'))()
    end)

pcall(function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/ZzeRPLoyd/gui_rivals/refs/heads/main/gui.lua', true))()
	end)

print('waiting main gui')

-- Ждем GUI с таймаутом 15 секунд, чтобы не зависнуть навсегда
local ui = nil
local elapsed = 0
repeat
	task.wait(0.1)
	elapsed = elapsed + 0.1
	ui = game:GetService('CoreGui'):FindFirstChild('FPSMenu', true)
until ui or elapsed > 15

if not ui then
	warn("GUI не загрузился за 15 секунд! Проверьте скрипт gui.lua")
	return
end

local mainFrame = ui:FindFirstChild('MainFrame')
local ctFrame = mainFrame and mainFrame:FindFirstChild('ContentFrame')
print('gui loaded', ui)

if not ctFrame then return end

local pvpContent = ctFrame:FindFirstChild('PVPContent')
local visualContent = ctFrame:FindFirstChild('VisualsContent')

--[[Функции обработки]]
local function handleBool(container, _fn)
	if not container then return end

	local defValue = container:GetAttribute('DefaultValue')
	local value = defValue or false

	local btn = container:FindFirstChildOfClass('TextButton')
	if not btn then return end

	-- Применяем дефолтное значение при загрузке (сразу включаем/выключаем)
	task.defer(function()
		if getgenv().library and (getgenv().library.silentModule or getgenv().library.espModule) and defValue then
			_fn(value, container)
		end
	end)

	btn.MouseButton1Click:Connect(function() 
		value = not value
		_fn(value, container)
	end)
end

local function handleInput(input : TextBox, requiredType, min, max, _fn)
	if not input then return end

	local currentValue = min
	local lastValue = min

	local function applyValue(value)
		input.Text = value
		_fn(value)
	end

	-- Применяем дефолтное значение
	task.defer(function()
		applyValue(currentValue)
	end)

	input.Focused:Connect(function() 
		input.Text = ''
		input.PlaceholderText = string.format('Enter Value: min %s; max %s', min, max)	
	end)

	input.FocusLost:Connect(function(enterPressed: boolean, inputThatCausedFocusLoss: InputObject) 
		local text = input.Text

		if requiredType == 'number' and not tonumber(text) then
			applyValue(lastValue)	
			return
		end

		local number = math.clamp(tonumber(text), min, max)

		lastValue = number
		currentValue = number

		applyValue(number)
	end)
end

--[[SILENT HANDLING]]
if pvpContent then
	local BoolSilent = pvpContent:FindFirstChild("Silent AimContainer")
	local BoolSilentFov = pvpContent:FindFirstChild('Show FOV CircleContainer')
	local SilentFovInput = pvpContent:FindFirstChild('Silent FOVContainer')
	local silentTargets = pvpContent:FindFirstChild('Silent TargetContainer')

	handleBool(BoolSilent, function(v)
		if getgenv().library and getgenv().library.silentModule then
			getgenv().library.silentModule.setConfig({State = v})
		end
	end)

	handleBool(BoolSilentFov, function(v)
		if getgenv().library and getgenv().library.silentModule then
			getgenv().library.silentModule.setConfig({ShowFOV = v})
		end
	end)

	if SilentFovInput then
		handleInput(SilentFovInput:FindFirstChild("Input"), 'number', 10, 1000, function(v)
			if getgenv().library and getgenv().library.silentModule then
				getgenv().library.silentModule.setConfig({FOVRadius = v})
			end
		end)
	end

	if silentTargets then
		silentTargets.ChildAdded:Connect(function(child: Instance) 
			if child.Name:find('Option') then
				child.MouseButton1Down:Once(function()
					if getgenv().library and getgenv().library.silentModule then
						getgenv().library.silentModule.setConfig({HitPart = child.Text})
					end
				end)
			end	
		end)
	end
end

--[[VISUALS HANDLING]]
if visualContent then
	local boxes_esp = visualContent:FindFirstChild('ESP BoxesContainer')

	handleBool(boxes_esp, function(v)
		if getgenv().library and getgenv().library.espModule then
			getgenv().library.espModule.setSetting('Box', v)
		end
	end)
end

print('Loyd hub loaded !')
