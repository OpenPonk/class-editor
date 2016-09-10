tests - meta
testTypeMethodSourceFor
	(input := FAMIXAttribute named: 'item') declaredType: (FAMIXClass named: 'Number').
	result := transformer typeMethodSourceFor: input.
	self
		assert: result source
		equals:
			'item_type
	^ Number'