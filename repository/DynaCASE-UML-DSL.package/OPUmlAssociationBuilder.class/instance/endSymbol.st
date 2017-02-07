accessing
endSymbol
	^ super endSymbol
		==>
			[ :nodes | 
			nodes = '>'
				ifTrue: [ {DCUmlAggregationKind none.
					true} ]
				ifFalse: [ nodes ] ]