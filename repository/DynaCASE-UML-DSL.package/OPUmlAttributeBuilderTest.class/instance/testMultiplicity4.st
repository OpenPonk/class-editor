tests
testMultiplicity4
	self parse: '[2..*]' rule: #multiplicity.
	self assert: result lower equals: 2.
	self assert: result upper equals: DCUnlimitedNatural max