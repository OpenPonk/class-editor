tests - accessors
testLazyGetterSourceFor
	(input := FAMIXAttribute named: 'item')
		defaultValue: (DCFAMIXValueSpecification from: '15').
	result := transformer getterSourceFor: input.
	self
		assert: result source
		equals:
			'item
	^ item ifNil: [ item := 15 ]'