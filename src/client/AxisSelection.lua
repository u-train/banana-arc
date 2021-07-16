local Roact = require(script.Parent.Parent.Libraries.Roact)
local TextButton = require(script.Parent.TextButton)
local C = require(script.Parent.Constants)

local AXES = {
	"X",
	"Y",
	"Z"
}

return function(Props)
	local Children = {}

	for Key, Axis in next, AXES do
		Children[Axis] = Roact.createElement(
			TextButton,
			{
				BorderSizePixel = Props.AxisOfRotation == Axis and 1,
				Size = UDim2.new(1/3, 0, 0, 25),
				Position = UDim2.new(1/3 * (Key - 1), 0, 0, 25),
				Text = Axis,
				MouseButton1Click = function()
					Props.AxisChanged(Axis)
				end
			}
		)
	end

	Children.Title = Roact.createElement(
		"TextLabel",
		{
			BorderSizePixel = 0,
			BackgroundColor3 = C.SECONDARY_BACKGROUND,
			TextColor3 = C.TEXT_COLOR,
			Text = "Axis of Rotation:",
			Size = UDim2.new(1, 0, 0, 25)
		}
	)

	return Roact.createElement(
		"Frame",
		{
			Size = UDim2.new(1, 0, 0, 50),
			BackgroundColor3 = C.SECONDARY_BACKGROUND,
			BorderSizePixel = 0,
			LayoutOrder = Props.LayoutOrder,
		},
		Children
	)
end