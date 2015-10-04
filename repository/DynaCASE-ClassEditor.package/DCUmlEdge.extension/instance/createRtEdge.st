*DynaCASE-ClassEditor-Manipulation
createRtEdge
	^ DCRTStyledConnection new
		withContinuousRectangleAttachPoint;
		head: self headDecorator;
		tail: self tailDecorator;
		color: self style strokeColor;
		width: self style strokeWidth;
		edgeFrom: source rtElement to: target rtElement