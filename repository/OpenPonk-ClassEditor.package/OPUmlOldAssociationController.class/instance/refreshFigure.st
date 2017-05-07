events - registering
refreshFigure
	self refreshEndFigure: self model sourceEnd decoratorSelector: #tailDecorator:.
	self refreshEndFigure: self model targetEnd decoratorSelector: #headDecorator:.
	self diagramElement changed.

	self diagramElement ownedElements size = 5
		ifTrue:
			[ 
			self diagramElement ownedElements first text: self model name.
			self diagramElement ownedElements first changed.

			self diagramElement ownedElements second text: (self model sourceEnd name ifNil: [ '' ]).
			self diagramElement ownedElements second changed.
			self diagramElement ownedElements third
				text: (self multiplicityRangeFor: self model sourceEnd multiplicity).
			self diagramElement ownedElements third changed.

			(self diagramElement ownedElements at: 4) text: (self model targetEnd name ifNil: [ '' ]).
			(self diagramElement ownedElements at: 4) changed.
			(self diagramElement ownedElements at: 5)
				text: (self multiplicityRangeFor: self model targetEnd multiplicity).
			(self diagramElement ownedElements at: 5) changed ].
	super refreshFigure