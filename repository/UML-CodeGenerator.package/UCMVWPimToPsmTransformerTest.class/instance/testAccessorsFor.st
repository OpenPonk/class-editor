tests
testAccessorsFor
	input := FAMIXAttribute named: 'item'.
	transformer context withAccessors.
	result := transformer accessorsFor: input.
	self assert: (result collect: #name) equals: #(item item:)