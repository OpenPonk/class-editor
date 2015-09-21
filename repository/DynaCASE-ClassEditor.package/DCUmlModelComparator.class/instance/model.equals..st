comparing
model: a equals: b
	a class = b class
		ifFalse: [ ^ false ].
	a class = DCUmlOperation
		ifTrue: [ ^ self operation: a equals: b ].
	a class = DCUmlParameter
		ifTrue: [ ^ self parameter: a equals: b ].
	a class = DCFAMIXMultiplicity
		ifTrue: [ ^ self multiplicity: a equals: b ].
	^ self notYetImplemented