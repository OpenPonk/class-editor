visitor
visitMethod: aMethod
	aMethod isStatic
		ifTrue: [ stream nextPut: $_ ].
	aMethod isAbstract
		ifTrue: [ stream nextPut: $/ ].
	stream nextPutAll: aMethod name.
	stream nextPut: $(.
	aMethod parameters
		do: [ :each | self visitParameter: each ]
		separatedBy: [ stream nextPutAll: ', ' ].
	stream nextPut: $).
	self visitTypeWithMultiplicity: aMethod