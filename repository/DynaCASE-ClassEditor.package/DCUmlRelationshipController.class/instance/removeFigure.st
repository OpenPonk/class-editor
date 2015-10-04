figures
removeFigure
	self diagramController deselectAll.
	diagramElement view
		ifNotNil: [ 
			diagramElement remove.
			diagramElement := nil ]