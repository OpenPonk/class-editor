utilities
paramNameForEnd: anEnd
	anEnd multiplicity upper > 1
		ifTrue: [ ^ 'aCollection' ].
	^ self typeNameForEnd: anEnd