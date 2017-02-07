visitor
visitTypeWithMultiplicity: aType
	aType declaredType ifNil: [ ^ self ].
	(aType isKindOf: FAMIXMethod)
		ifTrue: [ stream
				nextPutAll: ' : ';
				nextPutAll: aType declaredType name;
				nextPutAll: aType multiplicity asOptionalString.
			^ self ].
	self visitType: aType declaredType withMultiplicity: aType multiplicity separator: ' : '