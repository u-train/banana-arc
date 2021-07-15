local Roact = require(script.Parent.Parent.Libraries.Roact)
local ControlledInput = Roact.Component:extend("ControlledInput")

function ControlledInput:init()
	self.InternalValue,
	self.UpdateInternalValue = Roact.createBinding(self.props.Value)
end

function ControlledInput:render()
	return Roact.createElement(
		"TextBox",
		{
			Text = self.Value,
			Size = self.props.Size,
			Position = self.props.Position,

			[Roact.Change.Text] = function(Rbx)
				self.UpdateInternalValue(Rbx.Text)
			end,
			[Roact.Event.Focused] = function()
				if self.props.ClearTextOnFocus then
					self.UpdateInternalValue("")
				end
			end,
			[Roact.Event.FocusLost] = function(Rbx)
				self.props.OnValueChanged(Rbx.Text)
				self.UpdateInternalValue(self.props.Value)
			end,

			ClearTextOnFocus = false,
		}
	)
end

return ControlledInput