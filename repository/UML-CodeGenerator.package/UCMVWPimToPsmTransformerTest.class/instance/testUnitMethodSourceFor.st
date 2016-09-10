tests - meta
testUnitMethodSourceFor
	(input := FAMIXAttribute named: 'item') unit: 'kg'.
	result := transformer unitMethodSourceFor: input.
	self
		assert: result source
		equals:
			'item_unit
	^ ''kg'''