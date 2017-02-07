figures
refreshFigure
	self refreshStereotype.
	self diagramElement text: self model umlSignature.
	self diagramElement localStyle
		fontUnderline: self model isStatic;
		fontItalic: self model isAbstract.
	self diagramElement changed.
	classController refreshFigure