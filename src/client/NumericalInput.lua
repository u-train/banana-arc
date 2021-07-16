local Roact = require(script.Parent.Parent.Libraries.Roact)
local ControlledInputComponent = require(script.Parent.ControlledInput)

local C = require(script.Parent.Constants)

return function(Props)
	return Roact.createElement(
		"Frame",
		{
			Size = UDim2.new(1, 0, 0, 50),
			BackgroundColor3 = C.SECONDARY_BACKGROUND,
			BorderSizePixel = 0,
			LayoutOrder = Props.LayoutOrder,
		},
		{
			Label = Roact.createElement(
				"TextLabel",
				{
					BorderSizePixel = 0,
					BackgroundColor3 = C.SECONDARY_BACKGROUND,
					TextColor3 = C.TEXT_COLOR,
					Text = Props.Label,
					Size = UDim2.new(1, 0, 0, 25)
				}
			),
			TextInput = Roact.createElement(
				ControlledInputComponent,
				{
					Value = Props.Value,
					ClearTextOnFocus = Props.ClearTextOnFocus,
					Position = UDim2.fromOffset(0, 25),
					Size = UDim2.new(1, 0, 0, 25),
					OnValueChanged = function(Text)
						local NewRotation = tonumber(Text)
						if NewRotation == nil then return end
						Props.ValueChanged(NewRotation)
					end
				}
			),
		}
	)
end