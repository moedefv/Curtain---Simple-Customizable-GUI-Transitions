local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGUI = Player.PlayerGui
local TransitionGUI = PlayerGUI:WaitForChild("TransitionGUI")
local GridFrame = TransitionGUI:WaitForChild("GridFrame")

local rng = Random.new()
local SelectedSquares = {}

local function GetRandomSquare()
	local randomNum = rng:NextInteger(1, 40)
	
	if SelectedSquares[randomNum] then
		repeat randomNum = rng:NextInteger(1, 40) until not SelectedSquares[randomNum]
	end
	
	SelectedSquares[randomNum] = true
	local randomSquare = GridFrame[randomNum]
	
	return randomSquare
end

local function GridIn(info, Color)
	local inTween
	
	for _ = 1, 40 do
		local square = GetRandomSquare()
		local UIScale = square:WaitForChild("UIScale")

		local scaleTween = TweenService:Create(UIScale, info, {Scale = 1})
		inTween = TweenService:Create(square, info, {BackgroundTransparency = 0})

		square.BackgroundColor3 = Color or Color3.fromRGB(0, 0, 0)

		scaleTween:Play()
		inTween:Play()

		task.wait(0.02)
	end
	
	inTween.Completed:Wait()
	table.clear(SelectedSquares)
end

local function GridOut(info, Color)
	local outTween
	
	for _ = 1, 40 do
		local square = GetRandomSquare()
		local UIScale = square:WaitForChild("UIScale")

		local scaleTween = TweenService:Create(UIScale, info, {Scale = 0})
		outTween = TweenService:Create(square, info, {BackgroundTransparency = 1})

		square.BackgroundColor3 = Color or Color3.fromRGB(0, 0, 0)

		scaleTween:Play()
		outTween:Play()
		
		task.wait(0.02)
	end
	
	outTween.Completed:Wait()
	table.clear(SelectedSquares)
end

return function(frame1, frame2, isScreenGuiFrame1, isScreenGuiFrame2, transitionConfig, customCallback)
	local info
	local Color
	
	if not transitionConfig then
		info = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
	else
		local Duration = transitionConfig["Duration"]
		local EasingStyle = transitionConfig["EasingStyle"]
		Color = transitionConfig["Color"]
		
		info = TweenInfo.new(Duration or 0.5, EasingStyle or Enum.EasingStyle.Linear)
	end
	
	local propertyToUseFrame1 = isScreenGuiFrame1 and "Enabled" or "Visible"
	local propertyToUseFrame2 = isScreenGuiFrame2 and "Enabled" or "Visible"
	
	GridIn(info, Color)
	
	if customCallback then customCallback() end
	
	if frame1 then
		frame1[propertyToUseFrame1] = false
	end
	
	frame2[propertyToUseFrame2] = true
		
	GridOut(info, Color)
end
