local Roact = require(script.Parent.Parent.Libraries.Roact)
local C = require(script.Parent.Constants)

local SIZE = UDim2.new(1, 0, 0, 25)

return function(Props)
	return Roact.createElement(
		"TextButton",
		{
			Text = Props.Text,
			LayoutOrder = Props.LayoutOrder,
			[Roact.Event.MouseButton1Click] = Props.MouseButton1Click,

			TextColor3 = C.TEXT_COLOR,
			BackgroundColor3 = C.SECONDARY_BACKGROUND,
			Size = SIZE,
			BorderSizePixel = 0,
		}
	)
end