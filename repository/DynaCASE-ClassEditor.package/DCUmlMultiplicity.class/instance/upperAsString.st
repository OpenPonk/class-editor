accessing
upperAsString
	^ self upper isInfinite
		ifTrue: [ '*' ]
		ifFalse: [ self upper asString ]