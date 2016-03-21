events - registering
refreshEndFigure: anEnd decoratorSelector: aSelector
	| decorator |
	anEnd opposite aggregation = DCUmlAggregationKind none
		ifTrue:
			[ decorator := anEnd isNavigable & anEnd opposite isNavigable not
				ifTrue: [ RTSimpleArrow ]
				ifFalse: [ RTNoDecorationShape ] ].
	anEnd opposite aggregation = DCUmlAggregationKind shared
		ifTrue: [ decorator := RTEmptyDiamond ].
	anEnd opposite aggregation = DCUmlAggregationKind composite
		ifTrue: [ decorator := RTFilledDiamond ].
	self diagramElement perform: aSelector with: decorator