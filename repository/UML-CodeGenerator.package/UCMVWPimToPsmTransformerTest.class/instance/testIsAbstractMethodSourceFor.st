tests - meta
testIsAbstractMethodSourceFor
	input := FAMIXClass named: 'Item'.
	result := transformer isAbstractMethodSourceFor: input.
	self
		assert: result source
		equals:
			'isAbstract
	^ self = Item'