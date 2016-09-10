transforming
metaForAttributeFor: anAttribute
	^ Array
		streamContents: [ :stream | 
			anAttribute defaultValue ifNotNil: [ stream nextPut: (self defaultMethodFor: anAttribute) ].
			stream nextPut: (self typeMethodFor: anAttribute).
			(anAttribute unit isNotNil and: [ anAttribute unit isNotEmpty ])
				ifTrue: [ stream nextPut: (self unitMethodFor: anAttribute) ] ]