tests
testMultiplicity1
	self parse: '[3]' rule: #multiplicity.
	self assert: result lower equals: 3.
	self assert: result upper equals: 3