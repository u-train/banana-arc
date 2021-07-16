return function(Part, AxisOfRotation, RotateBy, Mirror)
	Mirror = (Mirror == false or Mirror == nil) and -1 or 1

	local RotateBySign = math.sign(RotateBy)
	local CornerOffset
	local ReturnOffset

	if AxisOfRotation == "X" then
		CornerOffset = Vector3.new(0, 1/2 * RotateBySign, 1/2 ) * Part.Size * Mirror
		ReturnOffset = Vector3.new(0, -1/2 * RotateBySign, 1/2) * Part.Size * Mirror
	elseif AxisOfRotation == "Y" then
		CornerOffset = Vector3.new(1/2, 0, 1/2 * RotateBySign) * Part.Size * Mirror
		ReturnOffset = Vector3.new(1/2, 0, -1/2 * RotateBySign) * Part.Size * Mirror
	elseif AxisOfRotation == "Z" then
		CornerOffset = Vector3.new(1/2 * RotateBySign, 1/2 , 0) * Part.Size * Mirror
		ReturnOffset = Vector3.new(-1/2 * RotateBySign, 1/2 , 0) * Part.Size * Mirror
	end

	return Part.CFrame:ToWorldSpace(
			CFrame.new(CornerOffset)
		):ToWorldSpace(
			CFrame.Angles(
				AxisOfRotation == "X" and math.rad(RotateBy) or 0,
				AxisOfRotation == "Y" and math.rad(RotateBy) or 0,
				AxisOfRotation == "Z" and math.rad(RotateBy) or 0
			)
		):ToWorldSpace(
			CFrame.new(ReturnOffset)
		)
end