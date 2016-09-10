tests - meta
testDefaultMethodSourceFor
	(input := FAMIXAttribute named: 'item')
		defaultValue: (DCFAMIXValueSpecification from: '15').
	result := transformer defaultMethodSourceFor: input.
	self
		assert: result body
		equals:
			'item_default
	^ 15'