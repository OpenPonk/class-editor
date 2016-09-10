transforming
typeFor: aType
	aType ifNil: [ ^ nil ].
	typesLookup at: aType ifAbsentPut: [ self classFor: aType ].
	^ typesLookup at: aType