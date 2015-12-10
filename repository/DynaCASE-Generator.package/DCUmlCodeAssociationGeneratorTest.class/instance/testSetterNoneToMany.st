tests
testSetterNoneToMany
	self ast: (generator setter: noneToMany targetEnd) equals: 'names: aCollection names := aCollection'