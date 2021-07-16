local CountDescendant
CountDescendant = function(Object)
	local Count = 1

	for _, Child in next, Object:GetChildren() do
		Count += CountDescendant(Child)
	end

	return Count
end

return function(CopiedFrom, Destination)
	local ShouldBe = CountDescendant(CopiedFrom)
	local Actual = CountDescendant(Destination)

	print(ShouldBe, Actual)
	while ShouldBe > Actual do
		Destination.DescendantAdded:Wait()

		Actual += 1
	end
end
