grammar
multiplicity
	^ super multiplicity
		==>
			[ :nodes | 
			| m |
			m := DCUmlMultiplicity new.
			nodes
				ifNotNil: [ 
					m
						lower: nodes first;
						upper: nodes second ].
			m ]