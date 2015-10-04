figures
removeFigure
	self diagramController deselectAll.
	self diagramElement owningElement: nil.
	diagramElement := nil
