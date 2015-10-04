events - registering
refreshFigure
	self diagramElement
		headDecorator:
			(self model targetEnd isNavigable
				ifTrue: [ RTSimpleArrow ]
				ifFalse: [ RTNoDecorationShape ]);
		tailDecorator:
			(self model sourceEnd isNavigable
				ifTrue: [ RTSimpleArrow ]
				ifFalse: [ RTNoDecorationShape ]).
	self diagramElement changed.
	super refreshFigure