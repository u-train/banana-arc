local Roact = require(script.Parent.Parent.Libraries.Roact)
local ControlledInputComponent = require(script.Parent.ControlledInput)
local TextButtonComponent = require(script.Parent.TextButton)

local C = require(script.Parent.Constants)

local NumericalInput = Roact.Component:extend("NumericalInput")

function NumericalInput:attemptStartHolding()
	self.props.ValueChanged(
		self.props.Value + self.IncrementingBy
	)

	self.Holding = true
	wait(0.5)

	if self.Holding and coroutine.status(self.HoldingLoop) == "suspended" then
		coroutine.resume(self.HoldingLoop)
	end
end

function NumericalInput:init()
	self.Holding = false
	self.IncrementingBy = 0
	self.ComponentActive = true

	self.HoldingLoop = coroutine.create(
		function()
			while self.ComponentActive do
				if self.Holding then
					self.props.ValueChanged(
						self.props.Value + self.IncrementingBy
					)

					wait(0.05)
				else
					coroutine.yield()
				end
			end
		end
	)
end

function NumericalInput:willUnmount()
	self.ComponentActive = false

	if coroutine.status(self.HoldingLoop) == "suspended" then
		coroutine.resume(self.HoldingLoop)
	end
end

function NumericalInput:render()
	return Roact.createElement(
		"Frame",
		{
			Size = UDim2.new(1, 0, 0, 50),
			BackgroundColor3 = C.SECONDARY_BACKGROUND,
			BorderSizePixel = 0,
			LayoutOrder = self.props.LayoutOrder,
		},
		{
			Label = Roact.createElement(
				"TextLabel",
				{
					BorderSizePixel = 0,
					BackgroundColor3 = C.SECONDARY_BACKGROUND,
					TextColor3 = C.TEXT_COLOR,
					Text = self.props.Label,
					Size = UDim2.new(1, 0, 0, 25)
				}
			),
			TextInput = Roact.createElement(
				ControlledInputComponent,
				{
					Value = self.props.Value,
					ClearTextOnFocus = self.props.ClearTextOnFocus,
					Position = UDim2.fromOffset(0, 25),
					Size = UDim2.new(1, -50, 0, 25),
					OnValueChanged = function(Text)
						local NewNumber = tonumber(Text)
						if NewNumber == nil then return end
						self.props.ValueChanged(NewNumber)
					end
				}
			),
			Increment = Roact.createElement(
				TextButtonComponent,
				{
					Text = "+",
					Size = UDim2.fromOffset(25, 25),
					Position = UDim2.new(1, -50, 0, 25),
					MouseButton1Down = function()
						self.IncrementingBy = 1
						self:attemptStartHolding()
					end,
					MouseButton1Up = function()
						self.Holding = false
					end,
					MouseLeave = function()
						if self.IncrementingBy == 1 then
							self.Holding = false
						end
					end
				}
			),
			Decrementing = Roact.createElement(
				TextButtonComponent,
				{
					Text = "-",
					Size = UDim2.fromOffset(25, 25),
					Position = UDim2.new(1, -25, 0, 25),
					MouseButton1Down = function()
						self.IncrementingBy = -1
						self:attemptStartHolding()
					end,
					MouseButton1Up = function()
						self.Holding = false
					end,
					MouseLeave = function()
						if self.IncrementingBy == -1 then
							self.Holding = false
						end
					end
				}
			)
		}
	)
end

return NumericalInput