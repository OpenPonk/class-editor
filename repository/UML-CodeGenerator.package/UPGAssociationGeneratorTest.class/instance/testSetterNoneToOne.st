tests
testSetterNoneToOne
	self ast: (generator setter: noneToOne targetEnd) equals: 'name: aName name := aName'