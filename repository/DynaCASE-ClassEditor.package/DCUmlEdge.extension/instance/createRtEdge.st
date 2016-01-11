*DynaCASE-ClassEditor-Manipulation
createRtEdge
	^ DCRTStyledConnection new
		withOrthogonalAttachPoint;
		head: self headDecorator asHead;
		tail: self tailDecorator asTail;
		color: self style strokeColor;
		width: self style strokeWidth;
		edgeFrom: source rtElement to: target rtElement