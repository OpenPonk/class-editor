building
multiplicity
	^ super multiplicity
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