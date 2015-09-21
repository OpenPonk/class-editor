adding/removing
addLast: aFigure
	(figures includes: aFigure)
		ifTrue: [ ^ self ].
	figures addLast: aFigure.
	aFigure parent: self.
	self changed