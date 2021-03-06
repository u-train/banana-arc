return function(StartingCFrame, Size, AxisOfRotation, RotateBy, Mirror)
	Mirror = (Mirror == false or Mirror == nil) and -1 or 1

	local RotateBySign = math.sign(RotateBy)
	local CornerOffset
	local ReturnOffset

	if AxisOfRotation == "X" then
		CornerOffset = Vector3.new(0, 1/2 * RotateBySign, 1/2 ) * Size * Mirror
		ReturnOffset = Vector3.new(0, -1/2 * RotateBySign, 1/2) * Size * Mirror
	elseif AxisOfRotation == "Y" then
		CornerOffset = Vector3.new(1/2, 0, 1/2 * RotateBySign) * Size * Mirror
		ReturnOffset = Vector3.new(1/2, 0, -1/2 * RotateBySign) * Size * Mirror
	elseif AxisOfRotation == "Z" then
		CornerOffset = Vector3.new(1/2 * RotateBySign, 1/2, 0) * Size * Mirror
		ReturnOffset = Vector3.new(-1/2 * RotateBySign, 1/2, 0) * Size * Mirror
	end

	return StartingCFrame:ToWorldSpace(
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