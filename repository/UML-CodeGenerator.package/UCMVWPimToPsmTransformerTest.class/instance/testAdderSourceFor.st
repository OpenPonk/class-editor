tests - accessors
testAdderSourceFor
	input := FAMIXAttribute named: 'items'.
	input multiplicity upper: 2.
	result := transformer adderSourceFor: input.
	self
		assert: result source
		equals:
			'addItem: anObject
	items add: anObject'