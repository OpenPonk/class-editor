tests - meta
testDefaultMethodSourceFor
	(input := FAMIXAttribute named: 'item')
		defaultValue: (DCFAMIXValueSpecification from: '15').
	result := transformer defaultMethodSourceFor: input.
	self
		assert: result source
		equals:
			'item_default
	^ 15'