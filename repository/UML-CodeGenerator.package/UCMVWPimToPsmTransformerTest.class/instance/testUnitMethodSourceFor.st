tests - meta
testUnitMethodSourceFor
	(input := FAMIXAttribute named: 'item') unit: 'kg'.
	result := transformer unitMethodSourceFor: input.
	self
		assert: result body
		equals:
			'item_unit
	^ ''kg'''