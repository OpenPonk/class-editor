visitor
visitType: aType
	| ref |
	aType ifNil: [ ^ self ].
	ref := aType uuid asString.
	(self isPrimitiveType: aType)
		ifTrue: [ ref := aType name ]
		ifFalse: [ self ensureType: aType ].
	writer tag: #type attributes: (Dictionary with: #xmi:idref -> ref)