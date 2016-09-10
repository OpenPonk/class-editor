tests
testClassAbstractFor
	input := FAMIXClass named: 'Item'.
	input isAbstract: true.
	result := transformer classFor: input.
	self deny: result isAbstract.
	self assert: result methods size equals: 1.
	self assert: result methods first name equals: 'isAbstract'