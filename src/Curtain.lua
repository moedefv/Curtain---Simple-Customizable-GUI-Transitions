local TransitionService = {}
TransitionService.__index = TransitionService

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGUI = Player.PlayerGui

local CreateTransitionFrames = require(script.CreateTransitionFrames)
local ConfigTypes = require(script.ConfigTypes)

function TransitionService.new()
	local self = setmetatable({}, TransitionService)
	
	local transitionGUI = PlayerGUI:FindFirstChild("TransitionGUI")
	if not transitionGUI then
		transitionGUI = Instance.new("ScreenGui")
		transitionGUI.IgnoreGuiInset = true
		transitionGUI.ResetOnSpawn = false
		transitionGUI.Name = "TransitionGUI"
		transitionGUI.Parent = PlayerGUI
		
		CreateTransitionFrames(transitionGUI)
	end
	
	return self
end

function TransitionService:Grid(frame1 : GuiObject, frame2 : GuiObject, transitionConfig : ConfigTypes.GridConfig, customCallback: (() -> ())?)	
	Transition("Grid", frame1, frame2, transitionConfig, customCallback)
end

function TransitionService:Slide(frame1 : GuiObject, frame2 : GuiObject, transitionConfig : ConfigTypes.SlideConfig, customCallback: (() -> ())?)	
	Transition("Slide", frame1, frame2, transitionConfig, customCallback)
end

function TransitionService:Fade(frame1 : GuiObject, frame2 : GuiObject, transitionConfig : ConfigTypes.FadeConfig, customCallback: (() -> ())?)	
	Transition("Fade", frame1, frame2, transitionConfig, customCallback)
end

function TransitionService:Iris(frame1 : GuiObject, frame2 : GuiObject, transitionConfig : ConfigTypes.IrisConfig, customCallback: (() -> ())?)
	Transition("Iris", frame1, frame2, transitionConfig, customCallback)
end

function Transition(transitionName, frame1, frame2, transitionConfig, customCallback)
	if not script.Transitions[transitionName] then
		error(`Invalid transition {transitionName}`)
	end
	
	if not frame2 then
		error(`Invalid frame {frame2}`)
	end
	
	if not frame1 then
		warn(`[{script.Name}]: Frame 1 is nil, assuming no source frame. Delete this warning in the script if you don't want it in your game.`)
	end
	
	local isScreenGuiFrame1 = frame1 and frame1:IsA("ScreenGui")
	local isScreenGuiFrame2 = frame2:IsA("ScreenGui")
	
	local transition = require(script.Transitions[transitionName])
	
	transition(frame1, frame2, isScreenGuiFrame1, isScreenGuiFrame2, transitionConfig, customCallback)
end

return TransitionService.new()


-- MADE BY THE GOAT MOEDEFV
