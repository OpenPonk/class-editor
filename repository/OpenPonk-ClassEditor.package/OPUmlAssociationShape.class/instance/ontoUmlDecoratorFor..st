accessing
ontoUmlDecoratorFor: aProperty
	| stereoNames markers |
	stereoNames := aProperty association appliedStereotypes collect: #umlClassName.
	markers := {#SubQuantityOf -> (OPUmlEdgeMarkers filledDiamondWith: 'Q').
	#SubCollectionOf -> (OPUmlEdgeMarkers filledDiamondWith: 'C').
	#MemberOf -> (OPUmlEdgeMarkers emptyDiamondWith: 'M').
	#ComponentOf -> (OPUmlEdgeMarkers emptyDiamondWith: 'C')} asDictionary.
	aProperty opposite aggregation = OPUMLAggregationKind composite
		ifTrue: [ (stereoNames includes: #SubQuantityOf)
				ifTrue: [ ^ markers at: #SubQuantityOf ].
			(stereoNames includes: #SubCollectionOf)
				ifTrue: [ ^ markers at: #SubCollectionOf ] ].
	aProperty opposite aggregation = OPUMLAggregationKind shared
		ifTrue: [ (stereoNames includes: #MemberOf)
				ifTrue: [ ^ markers at: #MemberOf ].
			(stereoNames includes: #ComponentOf)
				ifTrue: [ ^ markers at: #ComponentOf ] ].
	^ nil