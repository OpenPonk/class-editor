as yet unclassified
attachFigure
	"add figure to the view"

	| el |
	el := self diagramElement.
	el view ifNil: [ el renderIn: self diagramController view ].
	self diagramController figureAdded: self figure.
	self refreshFigure