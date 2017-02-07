tests - accessors
testLazyGetterSourceFor
	(input := FAMIXAttribute named: 'item')
		defaultValue: (OPFAMIXValueSpecification from: '15').
	result := transformer getterSourceFor: input.
	self
		assert: result body
		equals:
			'item
	^ item ifNil: [ item := 15 ]'