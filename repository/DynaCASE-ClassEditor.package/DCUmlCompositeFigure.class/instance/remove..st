adding
remove: aFigure
	aFigure parent: nil.
	aFigure remove.
	figures remove: aFigure.
	self update.
	self updateParent