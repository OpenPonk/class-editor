tests - accessors
testGetterSourceFor
	input := FAMIXAttribute named: 'item'.
	result := transformer getterSourceFor: input.
	self
		assert: result source
		equals:
			'item
	^ item'