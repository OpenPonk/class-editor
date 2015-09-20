adding/removing
remove: aFigure
	aFigure parent: nil.
	aFigure remove.
	figures remove: aFigure.
	self changed