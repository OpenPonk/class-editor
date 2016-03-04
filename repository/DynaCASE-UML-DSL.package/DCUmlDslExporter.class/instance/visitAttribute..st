visitor
visitAttribute: anAttribute
	anAttribute isStatic
		ifTrue: [ stream nextPut: $_ ].
	stream nextPutAll: anAttribute name.

	self visitTypeWithMultiplicity: anAttribute.
	anAttribute defaultValue
		ifNotNil:
			[ :val | 
			stream
				nextPutAll: ' = ';
				nextPutAll: val valueExpression ]