printing
printValue
	^ self isUnlimited
		ifTrue: [ '*' ]
		ifFalse: [ value asString ]