tests
testAccessorsNotFor
	input := FAMIXAttribute named: 'item'.
	transformer context withoutAccessors.
	result := transformer accessorsFor: input.
	self assert: result equals: #()