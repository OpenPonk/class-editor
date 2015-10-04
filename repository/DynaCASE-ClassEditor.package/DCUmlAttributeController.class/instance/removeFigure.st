figures
removeFigure
	self diagramController deselectAll.
	self diagramElement remove.
	diagramElement owningElement: nil.
	diagramElement := nil