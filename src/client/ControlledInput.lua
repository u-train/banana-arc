local Roact = require(script.Parent.Parent.Libraries.Roact)
local C = require(script.Parent.Constants)

local ControlledInput = Roact.Component:extend("ControlledInput")

function ControlledInput:init()
	self.InternalValue,
	self.UpdateInternalValue = Roact.createBinding(self.props.Value)
end

function ControlledInput:render()
	return Roact.createElement(
		"TextBox",
		{
			Text = self.InternalValue,
			Size = self.props.Size or C.DEFAULT_SIZE,
			Position = self.props.Position,
			LayoutOrder = self.props.LayoutOrder or 0,
			BorderSizePixel = self.props.BorderSizePixel or 0,

			TextColor3 = C.TEXT_COLOR,
			BackgroundColor3 = C.SECONDARY_BACKGROUND,
			BorderColor3 = C.TEXT_COLOR,
			BorderMode = Enum.BorderMode.Inset,

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