local Roact = require(script.Parent.Parent.Libraries.Roact)

local SelectionPreview = Roact.Component:extend("SelectionPreview")

function SelectionPreview:init()
	self.PreviewPartRef = Roact.createRef()
end

function SelectionPreview:render()
	return Roact.createElement(
		"Part",
		{
				CFrame = self.props.CFrame,
				Size = self.props.Size,
				[Roact.Ref] = self.PreviewPartRef,
				Anchored = true,
				CanCollide = false,
				CanTouch = false,
				Locked = true,
				Transparency = 1,
		},
		{
			PreviewSelection = Roact.createElement(
				"SelectionBox",
				{
					Color3 = Color3.fromRGB(255, 247, 202),
					SurfaceColor3 = Color3.fromRGB(244, 234, 216),
					LineThickness = 0.025,
					SurfaceTransparency = 0.75,
					Adornee = self.PreviewPartRef
				}
			)
		}
	)
end

return SelectionPreview