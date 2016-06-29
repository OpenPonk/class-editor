templates
adder: anEnd
	self assert: anEnd multiplicity upper > 1.
	anEnd opposite isNavigable
		ifFalse: [ ^ self addNoneToMany: anEnd ].
	^ anEnd opposite multiplicity upper = 1
		ifTrue: [ self addOneToMany: anEnd ]
		ifFalse: [ self addManyToMany: anEnd ]