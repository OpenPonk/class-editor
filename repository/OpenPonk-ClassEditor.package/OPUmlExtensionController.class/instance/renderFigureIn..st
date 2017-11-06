figures
renderFigureIn: aView
	diagramElement := self createDiagramElement.
	diagramElement
		ends:
			{diagramController diagramElementForModel: self model ownedEnd type.
			diagramController
				diagramElementForModel: (self model memberEnds copyWithout: self model ownedEnd) first type}.
	diagramElement renderIn: aView.
	diagramController figureAdded: self figure.
	self refreshFigure