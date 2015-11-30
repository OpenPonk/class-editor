tests
testSetterOneToNone
	self ast: (generator setter: oneToNone targetEnd) equals: 'name: aName name := aName'