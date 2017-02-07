accessing
startSymbol
	^ super startSymbol
		==>
			[ :nodes | 
			nodes = '<'
				ifTrue: [ {OPUmlAggregationKind none.
					true} ]
				ifFalse: [ nodes ] ]