figures
renderFigureIn: aView
	diagramElement := self createDiagramElement.
	diagramElement source: (diagramController diagramElementForModel: self model specific).
	diagramElement target: (diagramController diagramElementForModel: self model general).
	diagramElement renderIn: aView.
	diagramController figureAdded: self figure.
	self refreshFigure