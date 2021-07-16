local NextCFrameOnArc = require(script.Parent.NextCFrameOnArc)

return function(
	StartingCFrame,
	Size,
	AxisOfRotation,
	RotatingBy,
	Iterations,
	Mirrored
)
	Iterations = Iterations or 1
	local CFrameList = {
		[0] = StartingCFrame
	}

	for i = 1, Iterations do
		CFrameList[i] = NextCFrameOnArc(
			CFrameList[i - 1],
			Size,
			AxisOfRotation,
			RotatingBy,
			Mirrored
		)
	end

	CFrameList[0] = nil
	return CFrameList
end