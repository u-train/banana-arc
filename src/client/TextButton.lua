local Roact = require(script.Parent.Parent.Libraries.Roact)
local C = require(script.Parent.Constants)

return function(Props)
	return Roact.createElement(
		"TextButton",
		{
			Text = Props.Text,
			LayoutOrder = Props.LayoutOrder or 0,
			BorderSizePixel = Props.BorderSizePixel or 0,
			Size = Props.Size or C.DEFAULT_SIZE,
			Position = Props.Position or UDim2.fromOffset(0, 0),
			[Roact.Event.MouseButton1Click] = Props.MouseButton1Click,

			TextColor3 = C.TEXT_COLOR,
			BackgroundColor3 = C.SECONDARY_BACKGROUND,
			BorderColor3 = C.TEXT_COLOR,
			BorderMode = Enum.BorderMode.Inset
		}
	)
end