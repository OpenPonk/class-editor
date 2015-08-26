tests
testMultiplicity2
	self parse: '[*]' rule: #multiplicity.
	self assert: result lower equals: 0.
	self assert: result upper equals: Float infinity