events - registering
attachFigure
	"add figure to the view"

	| el |
	el := self diagramElement.
	el view ifNil: [ el renderIn: self diagramController view ].
	self figure @ DCRTConnectionHandles.
	"self figure @ DCRTOrthogonalHandles."
	self diagramController figureAdded: self figure.
	self refreshFigure