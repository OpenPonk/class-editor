building
multiplicity
	^ super multiplicity
		==>
			[ :nodes | 
			| m |
			m := OPFAMIXMultiplicity new.
			nodes
				ifNotNil: [ 
					m
						lower: nodes first;
						upper: nodes second ].
			m ]