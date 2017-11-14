initialization
createConnection
	^ (OPRTStyledConnection new
		attachPoint: (OPRTOrthogonalAttachPoint new offset: 30);
		color: self style strokeColor;
		head: (self headDecorator asHead color: Color yellow);
		tail: self tailDecorator asTail;
		width: self style strokeWidth;
		decorate: [ :deco | deco dashedLine ];
		edgeFrom: source rtElement to: target rtElement)
		model: self;
		yourself