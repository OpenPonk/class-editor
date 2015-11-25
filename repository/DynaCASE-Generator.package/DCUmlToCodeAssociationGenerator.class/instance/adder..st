templates
adder: anEnd
	self assert: anEnd multiplicity upper > 1.
	^ anEnd opposite multiplicity upper = 1
		ifTrue: [ self addOneToMany: anEnd ]
		ifFalse: [ self addManyToMany: anEnd ]