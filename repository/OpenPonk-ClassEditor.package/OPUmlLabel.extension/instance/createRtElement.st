*OpenPonk-ClassEditor-Manipulation
createRtElement
	^ RTStyledLabel new
		height: self style fontSize;
		color: #fontColor;
		text: #text;
		emphasis: #emphasis;
		elementOn: self