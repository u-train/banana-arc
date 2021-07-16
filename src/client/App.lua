local Roact = require(script.Parent.Parent.Libraries.Roact)
local NextPartOnArc = require(script.Parent.NextPartOnArc)
local TextButtonComponent = require(script.Parent.TextButton)
local AxisSelectionComponent = require(script.Parent.AxisSelection)
local RotatingByComponent = require(script.Parent.RotatingBy)

local C = require(script.Parent.Constants)

local App = Roact.Component:extend("App")

function App:init()
	self:setState({
		Equipped = false,
		SelectedPart = nil,
		AxisOfRotation = "X",
		Mirrored = false,
		RotatingBy = 15
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
				"Frame",
				{
					Size = UDim2.new(0, 150, 0, 206),
					Position = UDim2.new(0, 5, 0.5, 0),
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = C.PRIMARY_BACKGROUND,
					BorderSizePixel = 0
				},
				{
					UIListLayout = Roact.createElement(
						"UIListLayout",
						{
							Padding = UDim.new(0, 5),
							SortOrder = Enum.SortOrder.LayoutOrder
						}
					),
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
						RotatingByComponent,
						{
							LayoutOrder = 4,
							RotatingBy = self.state.RotatingBy,
							RotatingByChanged = function(NewRotation)
								self:setState({
									RotatingBy = NewRotation
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

								local NewPart = NextPartOnArc(
									self.state.SelectedPart,
									self.state.AxisOfRotation,
									self.state.RotateBy,
									self.state.Mirroring
								)

								NewPart.Parent = self.state.SelectedPart.Parent

								self:setState({
									SelectedPart = NewPart
								})
							end
						}
					),
					
				}
			)
		}
	)
end

return App