comparing
parameter: a equals: b
	(self name: a name equals: b name)
		ifFalse: [ ^ false ].
	a defaultValue = b defaultValue
		ifFalse: [ ^ false ].
	a type = b type
		ifFalse: [ ^ false ].
	(self multiplicity: a multiplicity equals: b multiplicity)
		ifFalse: [ ^ false ].
	^ true