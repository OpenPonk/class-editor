tests - meta
testIsAbstractMethodSourceFor
	input := FAMIXClass named: 'Item'.
	result := transformer isAbstractMethodSourceFor: input.
	self
		assert: result body
		equals:
			'isAbstract
	^ self = Item'