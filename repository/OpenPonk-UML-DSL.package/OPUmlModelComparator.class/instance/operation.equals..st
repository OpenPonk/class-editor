comparing
operation: a equals: b
	(self name: a name equals: b name)
		ifFalse: [ ^ false ].
	a parameters size = b parameters size
		ifFalse: [ ^ false ].
	(a declaredType = nil & (b declaredType = nil)
		or:
			[ 
			(self name: a declaredType name equals: b declaredType)
				and:
					[ 
					self
						multiplicity: a declaredType multiplicity
						equals: b declaredType multiplicity ] ])
		ifFalse: [ ^ false ].

	a parameters
		withIndexDo:
			[ :each :i | 
			(self parameter: each equals: (b parameters at: i))
				ifFalse: [ ^ false ] ].
	^ true