rendering
renderFigureIn: aView
	diagramElement := self createDiagramElement.
	diagramElement
		source: (diagramController diagramElementForModel: self model memberEnds first type).
	diagramElement
		target: (diagramController diagramElementForModel: self model memberEnds second type).
	diagramElement renderIn: aView.
	diagramController figureAdded: self figure.
	self refreshFigure