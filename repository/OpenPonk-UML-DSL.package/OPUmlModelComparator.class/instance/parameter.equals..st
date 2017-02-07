comparing
parameter: a equals: b
	(self name: a name equals: b name)
		ifFalse: [ ^ false ].
"	a defaultValue = b defaultValue
		ifFalse: [ ^ false ]."
	(self name: a declaredType name equals: b declaredType name)
		ifFalse: [ ^ false ].
	(self multiplicity: a multiplicity equals: b multiplicity)
		ifFalse: [ ^ false ].
	^ true