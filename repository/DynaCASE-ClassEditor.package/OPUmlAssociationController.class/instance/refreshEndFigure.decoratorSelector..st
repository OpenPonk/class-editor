events - registering
refreshEndFigure: anEnd decoratorSelector: aSelector
	| decorator |
	anEnd opposite aggregation = OPUmlAggregationKind none
		ifTrue:
			[ decorator := anEnd isNavigable & anEnd opposite isNavigable not
				ifTrue: [ RTSimpleArrow ]
				ifFalse: [ RTNoDecorationShape ] ].
	anEnd opposite aggregation = OPUmlAggregationKind shared
		ifTrue: [ decorator := RTEmptyDiamond ].
	anEnd opposite aggregation = OPUmlAggregationKind composite
		ifTrue: [ decorator := RTFilledDiamond ].
	self diagramElement perform: aSelector with: decorator