local Roact = require(script.Parent.Parent.Libraries.Roact)

local Merge = function(Destination, ...)
	for _, Source in next, {...} do
		for Key, Value in next, Source do
			Destination[Key] = Value
		end
	end

	return Destination
end

local ListLayout = Roact.Component:extend("ListLayout")

function ListLayout:init()
	self.SizeBinding, self.UpdateSizeBinding = Roact.createBinding(
		UDim2.new(
			self.props.Width,
			UDim.new(
				0,
				0
			)
		)
	)
end

function ListLayout:render()
	return Roact.createElement(
		"Frame",
		{
			Size = self.SizeBinding,
			Position = self.props.Position,
			AnchorPoint = self.props.AnchorPoint,
			BackgroundColor3 = self.props.BackgroundColor3,
			BorderSizePixel = self.props.BorderSizePixel
		},
		{
			Roact.createElement(
				"Frame",
				{
					Size = UDim2.new(1, -10, 1, -10),
					Position = UDim2.new(0, 5, 0, 5),
					Transparency = 1,
				},
				Merge(
					{
						UIListLayout = Roact.createElement(
							"UIListLayout",
							{
								Padding = UDim.new(0, 5),
								SortOrder = Enum.SortOrder.LayoutOrder,
								[Roact.Change.AbsoluteContentSize] = function(Rbx)
									self.UpdateSizeBinding(
										UDim2.new(
											self.props.Width,
											UDim.new(
												0,
												Rbx.AbsoluteContentSize.Y + 10
											)
										)
									)
								end
							}
						),
					},
					self.props[Roact.Children]
				)
			)
		}
	)
end

return ListLayout


--[[[
Size = UDim2.new(0, 150, 0, 206),
			Position = UDim2.new(0, 5, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = C.PRIMARY_BACKGROUND,
			BorderSizePixel = 0
		}
]]