accessing
endSymbol
	^ super endSymbol
		==>
			[ :nodes | 
			nodes = '>'
				ifTrue: [ {OPUmlAggregationKind none.
					true} ]
				ifFalse: [ nodes ] ]