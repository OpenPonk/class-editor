rendering
renderFigureIn: aView
	diagramElement := self createDiagramElement.
	diagramElement
		source: (diagramController diagramElementForModel: self model memberEnds first owningClass).
	diagramElement
		target: (diagramController diagramElementForModel: self model memberEnds second owningClass).
	diagramElement renderIn: aView.
	diagramController figureAdded: self figure.
	self refreshFigure