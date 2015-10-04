figures
refreshFigure
	self diagramElement text: (self famixTextFor: self model).
	self diagramElement localStyle
		fontUnderline: self model isStatic;
		fontItalic: self model isAbstract.
	self diagramElement changed