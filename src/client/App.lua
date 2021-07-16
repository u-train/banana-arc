local Roact = require(script.Parent.Parent.Libraries.Roact)
local ControlledInput = require(script.Parent.ControlledInput)

local App = Roact.Component:extend("App")

function App:init()
	self:setState({
		Equipped = false,
		SelectedPart = nil,
		RotatingOn = "X",
		Mirror = false,
		Rotation = 15
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
			Roact.createElement(
				"Frame",
				{
					Size = UDim2.new(0, 150, 0, 206),
					Position = UDim2.new(0, 5, 0.5, 0),
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					BorderSizePixel = 0
				},
				{
					Title = Roact.createElement(
						"TextLabel",
						{
							BackgroundColor3 = Color3.fromRGB(35, 35, 35),
							BorderSizePixel = 0,
							Size = UDim2.new(1, 0, 0, 25),
							Font = Enum.Font.SourceSansSemibold,
							Text = "Banana",
							TextColor3 = Color3.fromRGB(255, 170, 0),
							TextSize = 18
						}
					),
				}
			)
		}
	)
end

return App