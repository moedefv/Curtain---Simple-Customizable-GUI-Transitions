local TransitionFrames = {
	Grid = {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Name = "GridFrame",
		
		Children = {
			Frames = {
				Count = 40,
				Columns = 10,
				Rows = 4,
			},
		},
	},
	
	Fade = {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Name = "FadeFrame",
		Visible = false,
	},
	
	Slide = {
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(1, 0),
		Name = "SlideFrame",
		Visible = false,
	},
	
	Iris = {
		Name = "IrisFrame",
		Size = UDim2.fromScale(0.078, 0.178),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Children = {
			UIScale = {
				Scale = 0
			},
			UICorner = {
				CornerRadius = UDim.new(1, 0)
			},
			UIAspectRatioConstraint = {}
		},
		Visible = false,
	},
}

function AddChildren(children, parent)
	for child, value in children do
		if child == "Frames" then
			local columns = value.Columns
			local rows = value.Rows
			local screenSize = workspace.CurrentCamera.ViewportSize
			local cellWidth = math.floor(screenSize.X / columns)
			local cellHeight = math.floor(screenSize.Y / rows)
			
			local squareCount = 0
			
			for row = 1, rows do
				for column = 1, columns do
					squareCount += 1
					local cellW = column == columns and screenSize.X - cellWidth * (columns - 1) or cellWidth
					local cellH = row == rows and screenSize.Y - cellHeight * (rows - 1) or cellHeight
					
					local centerX = cellWidth * (column - 1) + cellW / 2
					local centerY = cellHeight * (row - 1) + cellH / 2
					
					local square = Instance.new("Frame")
					square.AnchorPoint = Vector2.new(0.5, 0.5)
					square.BackgroundTransparency = 1
					square.BorderSizePixel = 0
					square.Size = UDim2.new(0, cellW, 0, cellH)
					square.Position = UDim2.new(0, centerX, 0, centerY)
					square.Name = squareCount
					square.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
					square.Parent = parent
					
					local uiScale = Instance.new("UIScale")
					uiScale.Scale = 0
					uiScale.Name = "UIScale"
					uiScale.Parent = square
				end
			end
			
			continue
		end
		
		local childInstance = Instance.new(child)
		
		for propertyName, property in value do
			childInstance[propertyName] = property
		end
		
		childInstance.Parent = parent
	end
end

return function(transitionGUI)
	local camera = workspace.CurrentCamera
	repeat task.wait() until camera.ViewportSize.X > 1
	
	for name, config in TransitionFrames do
		local frame = Instance.new("Frame")
		
		for property, value in config do
			if property == "Children" then
				AddChildren(value, frame)
				continue
			end
			
			frame[property] = value
		end
		
		frame.Parent = transitionGUI
	end
	
	
	local GridFrame = transitionGUI:WaitForChild("GridFrame")
	
	local columns = 10
	local rows = 4
	workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		local screenSize = workspace.CurrentCamera.ViewportSize
		local cellWidth = math.floor(screenSize.X / columns)
		local cellHeight = math.floor(screenSize.Y / rows)

		for _, square in GridFrame:GetChildren() do
			if not square:IsA("Frame") then continue end

			local index = tonumber(square.Name)
			local column = ((index - 1) % columns) + 1
			local row = math.floor((index - 1) / columns) + 1

			local cellW = column == columns and screenSize.X - cellWidth * (columns - 1) or cellWidth
			local cellH = row == rows and screenSize.Y - cellHeight * (rows - 1) or cellHeight

			local centerX = cellWidth * (column - 1) + cellW / 2
			local centerY = cellHeight * (row - 1) + cellH / 2

			square.Size = UDim2.new(0, cellW, 0, cellH)
			square.Position = UDim2.new(0, centerX, 0, centerY)
		end
	end)
end
