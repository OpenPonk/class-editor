tests
testSetterOneToNone
	result := generator setter: oneToNone targetEnd.
	self ast: result equals: 'name: aName name := aName'