accessing
startSymbol
	^ super startSymbol
		==>
			[ :nodes | 
			nodes = '<'
				ifTrue: [ {DCUmlAggregationKind none.
					true} ]
				ifFalse: [ nodes ] ]