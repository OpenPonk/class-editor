comparing
model: a equals: b
	a class = b class
		ifFalse: [ ^ false ].
	a class = FAMIXMethod
		ifTrue: [ ^ self operation: a equals: b ].
	a class = FAMIXParameter
		ifTrue: [ ^ self parameter: a equals: b ].
	a class = OPFAMIXMultiplicity
		ifTrue: [ ^ self multiplicity: a equals: b ].
	^ self notYetImplemented