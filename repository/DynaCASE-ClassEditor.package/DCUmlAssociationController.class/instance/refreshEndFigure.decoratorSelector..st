events - registering
refreshEndFigure: anEnd decoratorSelector: aSelector
	| decorator |
	anEnd aggregation = DCUmlAggregationKind none
		ifTrue:
			[ decorator := anEnd isNavigable & anEnd opposite isNavigable not
				ifTrue: [ RTSimpleArrow ]
				ifFalse: [ RTNoDecorationShape ] ].
	anEnd aggregation = DCUmlAggregationKind shared
		ifTrue: [ decorator := RTEmptyDiamond ].
	anEnd aggregation = DCUmlAggregationKind composite
		ifTrue: [ decorator := RTFilledDiamond ].
	self diagramElement perform: aSelector with: decorator