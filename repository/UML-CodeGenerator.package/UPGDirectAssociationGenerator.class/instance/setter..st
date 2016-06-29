templates
setter: anEnd
	anEnd isNavigable & anEnd opposite isNavigable not
		ifTrue: [ ^ self someToNone: anEnd ].
	anEnd multiplicity upper = 1 & (anEnd opposite multiplicity upper = 1)
		ifTrue: [ ^ self oneToOne: anEnd ].
	anEnd multiplicity upper > 1
		ifTrue: [ ^ self manySetter: anEnd ].
	anEnd multiplicity upper = 1
		ifTrue: [ ^ self manyToOne: anEnd ].
	self error: 'Unreachable'