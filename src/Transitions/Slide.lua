local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGUI = Player.PlayerGui
local TransitionGUI = PlayerGUI:WaitForChild("TransitionGUI")
local SlideFrame = TransitionGUI:WaitForChild("SlideFrame")

local FramePosition

local Directions = {
	LeftIn = UDim2.fromScale(1, 0),
	RightIn = UDim2.fromScale(-1, 0),
	TopIn = UDim2.fromScale(0, -1),
	BottomIn = UDim2.fromScale(0, 1),
	
	LeftOut = UDim2.fromScale(-1, 0),
	RightOut = UDim2.fromScale(1, 0),
	TopOut = UDim2.fromScale(0, 1),
	BottomOut = UDim2.fromScale(0, -1),
}

local function SlideIn(info, Color, Direction)
	if not Direction then Direction = "Left" end
		
	FramePosition = Directions[`{Direction}In`]
	
	SlideFrame.Position = FramePosition or UDim2.fromScale(1, 0)
	SlideFrame.BackgroundColor3 = Color or Color3.fromRGB(0, 0, 0)
	
	local inTween = TweenService:Create(SlideFrame, info, {Position = UDim2.fromScale(0, 0)})
	
	SlideFrame.Visible = true
	inTween:Play()
	inTween.Completed:Wait()
end

local function SlideOut(info, Color, Direction, ReverseOut)
	if not Direction then Direction = "Left" end
	
	local TargetDirection = Directions[`{Direction}Out`]
	
	if ReverseOut then TargetDirection = FramePosition end
	
	local outTween = TweenService:Create(SlideFrame, info, {Position = TargetDirection or UDim2.fromScale(-1, 0)})
	
	outTween:Play()
	outTween.Completed:Wait()
	SlideFrame.Visible = false
end

return function(frame1, frame2, isScreenGuiFrame1, isScreenGuiFrame2, transitionConfig, customCallback)
	local info
	local Color
	local Direction
	local ReverseOut

	if not transitionConfig then
		info = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
	else
		local Speed = transitionConfig["Speed"]
		local EasingStyle = transitionConfig["EasingStyle"]
		
		Direction = transitionConfig["Direction"] 
		Color = transitionConfig["Color"]
		ReverseOut = transitionConfig["ReverseOut"]

		info = TweenInfo.new(Speed or 0.5, EasingStyle or Enum.EasingStyle.Linear)
	end

	local propertyToUseFrame1 = isScreenGuiFrame1 and "Enabled" or "Visible"
	local propertyToUseFrame2 = isScreenGuiFrame2 and "Enabled" or "Visible"

	SlideIn(info, Color, Direction)

	if customCallback then customCallback() end

	if frame1 then
		frame1[propertyToUseFrame1] = false
	end

	frame2[propertyToUseFrame2] = true

	SlideOut(info, Color, Direction, ReverseOut)
end
