figures
removeFigure
	self diagramController deselectAll.
	self realFigure parent remove: self realFigure.
	figure := nil