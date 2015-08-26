comparing
operation: a equals: b
	(self name: a name equals: b name)
		ifFalse: [ ^ false ].
	a parameters size = b parameters size
		ifFalse: [ ^ false ].
	(a returnParameter = nil & (b returnParameter = nil)
		or: [ self parameter: a returnParameter equals: b returnParameter ])
		ifFalse: [ ^ false ].
	a parameters
		withIndexDo:
			[ :each :i | 
			(self parameter: each equals: (b parameters at: i))
				ifFalse: [ ^ false ] ].
	^ true