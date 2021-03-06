local Roact = require(script.Parent.Parent.Libraries.Roact)
local TextButtonComponent = require(script.Parent.TextButton)
local AxisSelectionComponent = require(script.Parent.AxisSelection)
local NumericalInputComponent = require(script.Parent.NumericalInput)
local PartSelectionComponent = require(script.Parent.PartSelection)
local ListLayoutComponent = require(script.Parent.ListLayout)

local GetListOfNextCFrames = require(script.Parent.GetListOfNextCFrames)
local C = require(script.Parent.Constants)

local CreatePart = script.Parent.Parent.CreatePart

local App = Roact.Component:extend("App")

function App:init()
	self:setState({
		Equipped = false,
		SelectedPart = nil,
		AxisOfRotation = "X",
		Mirrored = false,
		RotatingBy = 15,
		Iterations = 1,
	})

	self._EquippedEvent = self.props.Equipped:Connect(
		function()
			self:setState({
				Equipped = true,
			})
		end
	)

	self._UnequippedEvent = self.props.Unequipped:Connect(
		function()
			self:setState({
				Equipped = false
			})
		end
	)
end

function App:willUmount()
	self._UnequippedEvent:Disconnect()
	self._EquippedEvent:Disconnect()
end

function App:render()
	return Roact.createElement(
		"ScreenGui",
		{
			Enabled = self.state.Equipped
		},
		{
			Container = Roact.createElement(
				ListLayoutComponent,
				{
					Width = UDim.new(0, 150),
					Position = UDim2.new(0, 5, 0.5, 0),
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = C.PRIMARY_BACKGROUND,
					BorderSizePixel = 0
				},
				{
					Title = Roact.createElement(
						"TextLabel",
						{
							BackgroundColor3 = C.SECONDARY_BACKGROUND,
							BorderSizePixel = 0,
							Size = UDim2.new(1, 0, 0, 25),
							Font = Enum.Font.SourceSansSemibold,
							Text = "Banana",
							TextColor3 = Color3.fromRGB(255, 170, 0),
							TextSize = 18,
							LayoutOrder = 1,
						}
					),
					MirrorControl = Roact.createElement(
						TextButtonComponent,
						{
							Text = self.state.Mirrored
								and "Mirroring"
								or "Not mirroring",
							LayoutOrder = 2,
							MouseButton1Click = function()
								self:setState({
									Mirrored = not self.state.Mirrored
								})
							end
						}
					),
					AxisSelectionControl = Roact.createElement(
						AxisSelectionComponent,
						{
							AxisOfRotation = self.state.AxisOfRotation,
							LayoutOrder = 3,
							AxisChanged = function(Axis)
								self:setState({
									AxisOfRotation = Axis
								})
							end,
						}
					),
					RotationControl = Roact.createElement(
						NumericalInputComponent,
						{
							Value = self.state.RotatingBy,
							Label = "Rotating By:",
							LayoutOrder = 4,
							ValueChanged = function(NewRotation)
								self:setState({
									RotatingBy = NewRotation
								})
							end
						}
					),
					IterationsControl = Roact.createElement(
						NumericalInputComponent,
						{
							Value = self.state.Iterations,
							Label = "Iterations:",
							LayoutOrder = 5,
							ValueChanged = function(NewIterationCount)
								if NewIterationCount <= 0 then
									return
								end

								if NewIterationCount > C.ITERATION_LIMIT then
									return
								end

								self:setState({
									Iterations = NewIterationCount
								})
							end
						}
					),
					ConfirmButton = Roact.createElement(
						TextButtonComponent,
						{
							Text = "Confirm",
							LayoutOrder = 10,
							MouseButton1Click = function()
								if self.state.SelectedPart == nil then
									return
								end

								local List = GetListOfNextCFrames(
									self.state.SelectedPart.CFrame,
									self.state.SelectedPart.Size,
									self.state.AxisOfRotation,
									self.state.RotatingBy,
									self.state.Iterations,
									self.state.Mirrored
								)

								local NewPart = CreatePart:InvokeServer(
									self.state.SelectedPart,
									List
								)

								self:setState({
									SelectedPart = NewPart
								})
							end
						}
					),
					PartSelectionController = self.state.Equipped and Roact.createElement(
						PartSelectionComponent,
						{
							NewSelectedPart = function(Part)
								self:setState({
									SelectedPart = Part
								})
							end,
							SelectedPart = self.state.SelectedPart,
							AxisOfRotation = self.state.AxisOfRotation,
							RotatingBy = self.state.RotatingBy,
							Mirrored = self.state.Mirrored,
							Iterations = self.state.Iterations
						}
					)
				}
			)
		}
	)
end

return App