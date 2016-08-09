figures
diagramInterchange: aDictionary
	(aDictionary isKindOf: Point)
		ifTrue: [ ^ super layout: aDictionary ].
	self figure model style fillColor: (aDictionary at: #fillStyle).
	self refreshFigure.
	super layout: (aDictionary at: #position)