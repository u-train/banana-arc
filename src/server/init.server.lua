require(
	script.Parent:WaitForChild("Shared"):WaitForChild("WaitUntilLoaded")
)(
	game.StarterPack.Bananas,
	script.Parent
)

local IterationLimit = require(script.Parent.Shared.IterationLimit)

local CreatePart = script.Parent.CreatePart
local LastPlaced = os.clock()
local Debounce = 0.25

CreatePart.OnServerInvoke = function(_, TargetPart, ListOfNewCFrames)
	if Debounce >= os.clock() - LastPlaced then
		return TargetPart
	end

	if #ListOfNewCFrames > IterationLimit then
		return TargetPart
	end

	LastPlaced = os.clock()

	local LastCFrame = table.remove(ListOfNewCFrames, #ListOfNewCFrames)

	local LastPart = TargetPart:Clone()
	LastPart.CFrame = LastCFrame
	LastPart.Parent = TargetPart.Parent

	for _, NewCFrame in next, ListOfNewCFrames do
		local NewPart = TargetPart:Clone()
		NewPart.CFrame = NewCFrame
		NewPart.Parent = TargetPart.Parent
	end

	return LastPart
end