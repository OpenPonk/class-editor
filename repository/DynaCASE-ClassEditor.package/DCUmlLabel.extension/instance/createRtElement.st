*DynaCASE-ClassEditor-Manipulation
createRtElement
	^ RTStyledLabel new
		height: self style fontSize;
		color: self style fontColor;
		text: #text;
		elementOn: self