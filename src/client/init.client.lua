local Tool = script.Parent
Tool.CanBeDropped = false
Tool.Enabled = true
Tool.ToolTip = "BANANA ROTAT E"
Tool.RequiresHandle = false

require(
	script.Parent:WaitForChild("Shared"):WaitForChild("WaitUntilLoaded")
)(
	game.StarterPack.Bananas,
	Tool
)

local Players = game:GetService("Players")
local Roact = require(script.Parent.Libraries.Roact)
local App = require(script.App)

local Handle = Roact.mount(
	Roact.createElement(
		App,
		{
			Equipped = Tool.Equipped,
			Unequipped = Tool.Unequipped,
		}
	),
	Players.LocalPlayer.PlayerGui,
	"Banana Tool"
)

local Character = Players.LocalPlayer.Character
if Character == nil then
	Character = Players.LocalPlayer.CharacterAdded:Wait()
end

Character:WaitForChild("Humanoid").Died:Connect(
	function()
		Roact.unmount(Handle)
	end
)
