visitor
visitType: aType
	aType ifNil: [ ^ self ].
	self ensureType: aType.
	writer tag: #type attributes: (Dictionary with: #xmi:idref -> aType uuid asString)