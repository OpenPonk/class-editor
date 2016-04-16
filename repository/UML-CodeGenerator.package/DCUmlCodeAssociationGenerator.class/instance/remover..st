templates
remover: anEnd
	self assert: anEnd multiplicity upper > 1.
	anEnd opposite isNavigable
		ifFalse: [ ^ self removeNoneToMany: anEnd ].
	^ anEnd opposite multiplicity upper = 1
		ifTrue: [ self removeOneToMany: anEnd ]
		ifFalse: [ self removeManyToMany: anEnd ]