*DynaCASE-ClassEditor-Manipulation
createRtElement
	^ RTBox new
		size: 0;
		color: self style fillColor;
		borderColor: self style strokeColor;
		borderWidth: self style strokeWidth;
		elementOn: self