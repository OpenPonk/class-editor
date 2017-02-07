accessing
multiplicity
	^ super multiplicity trim
		==>
			[ :nodes | 
			| m |
			m := DCFAMIXMultiplicity new.
			nodes
				ifNotNil: [ 
					m
						lower: nodes first;
						upper: nodes second ].
			m ]