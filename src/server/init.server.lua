require(
	script.Parent:WaitForChild("Shared"):WaitForChild("WaitUntilLoaded")
)(
	game.StarterPack.Bananas,
	script.Parent
)

local CreatePart = script.Parent.CreatePart
local LastPlaced = os.clock()
local Debounce = 0.5

CreatePart.OnServerInvoke = function(_, TargetPart, NewCFrame)
	if Debounce >= os.clock() - LastPlaced then
		return TargetPart
	end

	LastPlaced = os.clock()
	local NewPart = TargetPart:Clone()
	NewPart.CFrame = NewCFrame
	NewPart.Parent = TargetPart.Parent
	return NewPart
end