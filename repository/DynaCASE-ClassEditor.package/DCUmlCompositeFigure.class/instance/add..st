adding
add: aFigure
	(figures includes: aFigure)
		ifTrue: [ ^ self ].
	figures add: aFigure.
	aFigure parent: self.
	self update.
	self updateParent