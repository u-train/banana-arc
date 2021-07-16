local UserInputService = game:GetService("UserInputService")
local Roact = require(script.Parent.Parent.Libraries.Roact)
local SelectionPreviewComponent = require(script.Parent.SelectionPreview)

local GetListOfNextCFrames = require(script.Parent.GetListOfNextCFrames)
local C = require(script.Parent.Constants)

local PartSelection = Roact.Component:extend("PartSelection")

function PartSelection:getListOfNextCFrames(Iterations)
	Iterations = Iterations or 1
	if self.props.SelectedPart then
		return GetListOfNextCFrames(
			self.props.SelectedPart.CFrame,
			self.props.SelectedPart.Size,
			self.props.AxisOfRotation,
			self.props.RotatingBy,
			Iterations,
			self.props.Mirrored
		)
	else
		return { CFrame.new() }
	end
end

function PartSelection:init()
	self.CurrentCFrame, self.UpdateCurrentCFrame = Roact.createBinding(
		table.unpack(
			self:getListOfNextCFrames(1)
		)
	)

	self.PreviewPartRef = Roact.createRef()

	self.MousePressed = UserInputService.InputBegan:Connect(
		function(InputObject, Processed)
			if Processed then return end
			if InputObject.UserInputType ~= Enum.UserInputType.MouseButton1 then
				return
			end

			local MousePosition = Vector2.new(
				InputObject.Position.X,
				InputObject.Position.Y
			)

			local Camera = workspace.CurrentCamera

			local UnitRay = Camera:ScreenPointToRay(
				MousePosition.X,
				MousePosition.Y,
				0
			)

			local NewRaycastParams = RaycastParams.new()
			NewRaycastParams.FilterDescendantsInstances = {
				self.PreviewPartRef.current
			}

			local RaycastResults = workspace:Raycast(
				UnitRay.Origin,
				UnitRay.Direction * C.RAYCAST_LENGTH,
				NewRaycastParams
			)

			if RaycastResults then
				local PossibleSelection = RaycastResults.Instance

				if PossibleSelection.Locked == false then
					return self.props.NewSelectedPart(RaycastResults.Instance)
				end
			end

			self.props.NewSelectedPart(Roact.None)
		end
	)
end

function PartSelection:willUnmount()
	self.MousePressed:Disconnect()
	self.MousePressed = nil
end

function PartSelection:render()
	self.UpdateCurrentCFrame(
		table.unpack(
			self:getListOfNextCFrames(1)
		)
	)

	if self.props.SelectedPart == nil then
		return
	end

	if self.props.SelectedPart.Parent == nil then
		return self.props.NewSelectedPart(Roact.None)
	end

	local Children = {}
	for Key, Value in next, self:getListOfNextCFrames(
		self.props.Iterations
	) do
		Children[Key] = Roact.createElement(
			SelectionPreviewComponent,
			{
				Size = self.props.SelectedPart.Size,
				CFrame = Value,
			}
		)
	end

	Children.SelectedPartHighlight = Roact.createElement(
		"SelectionBox",
		{
			Color3 = Color3.fromRGB(255, 155, 182),
			SurfaceColor3 = Color3.fromRGB(255, 121, 179),
			LineThickness = 0.025,
			SurfaceTransparency = 0.75,
			Adornee = self.props.SelectedPart
		}
	)

	return Roact.createElement(
		Roact.Portal,
		{
			target = workspace
		},
		{
			BananaTool = Roact.createElement(
				"Folder",
				{},
				Children
			)
		}
	)
end

return PartSelection