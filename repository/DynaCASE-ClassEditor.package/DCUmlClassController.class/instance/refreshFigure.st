figures
refreshFigure
	nameLabel text: self model name.
	nameLabel localStyle fontItalic: self model isAbstract.
	nameLabel changed.
	self diagramElement changed.
	super refreshFigure