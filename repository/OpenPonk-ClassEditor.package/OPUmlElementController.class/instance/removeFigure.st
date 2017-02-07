figures
removeFigure
	self diagramController deselectAll.
	self diagramElement remove.
	self diagramElement owningElement: nil.
	diagramElement := nil