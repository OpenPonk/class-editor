adding
attachFigure
	| el |
	el := self diagramElement.
	el view ifNil: [ el renderIn: self diagramController view ].
	self diagramController figureAdded: self figure.
	self refreshFigure.
	self figure @ RTDraggableSnapToGrid