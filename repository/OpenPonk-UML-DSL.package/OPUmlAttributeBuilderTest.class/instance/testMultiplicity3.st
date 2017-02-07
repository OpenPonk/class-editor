tests
testMultiplicity3
	self parse: '[2..5]' rule: #multiplicity.
	self assert: result lower equals: 2.
	self assert: result upper equals: 5