tests - meta
testIsAbstractMethodFor
	input := FAMIXClass named: 'Item'.
	result := transformer isAbstractMethodFor: input.
	self assert: result name equals: 'isAbstract'.
	self assert: result protocol equals: 'testing'.
	self assert: result isStatic