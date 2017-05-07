figures
renderFigureIn: aView
	diagramElement := self createDiagramElement.
	diagramElement
		owningElement: (diagramController controllerForModel: model owningClass) diagramElement operations.
	diagramElement renderIn: aView.
	diagramController figureAdded: self figure.
	self refreshFigure