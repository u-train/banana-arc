local Roact = require(script.Parent.Parent.Libraries.Roact)
local App = Roact.Component:extend("App")


function App:init()
	self:setState({
		Equipped = false,
	})

	self._EquippedEvent = self.props.OnEquipped:Connect(
		function()
			self:setState({
				Equipped = true,
			})
		end
	)

	self._UnequippedEvent = self.props.OnUnequipped:Connect(
		function()
			self:setState({
				Equipped = false
			})
		end
	)
end

function App:render()
	return Roact.createElement(
		"ScreenGui",
		{
			Enabled = self.state.Equipped
		},
		{
			Roact.createElement(
				"TextLabel",
				{
					Text = "Hello",
					Size = UDim2.new(0, 200, 0, 50)
				}
			)
		}
	)
end

return App