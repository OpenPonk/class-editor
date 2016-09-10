tests - accessors
testGetterSourceFor
	input := FAMIXAttribute named: 'item'.
	result := transformer getterSourceFor: input.
	self
		assert: result body
		equals:
			'item
	^ item'