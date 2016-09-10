tests - meta
testTypeMethodSourceFor
	(input := FAMIXAttribute named: 'item') declaredType: (FAMIXClass named: 'Number').
	result := transformer typeMethodSourceFor: input.
	self
		assert: result body
		equals:
			'item_type
	^ Number'