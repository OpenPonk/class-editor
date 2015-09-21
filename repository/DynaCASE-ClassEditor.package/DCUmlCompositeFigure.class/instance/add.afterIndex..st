adding/removing
add: aFigure afterIndex: anIndex
	(figures includes: aFigure)
		ifTrue: [ ^ self ].
	figures add: aFigure afterIndex: anIndex.
	aFigure parent: self.
	self changed