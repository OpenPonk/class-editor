tests
testMultiplicity
	self parse: '' rule: #multiplicity.
	self assert: result class equals: OPFAMIXMultiplicity.
	self assert: result lower equals: 1.
	self assert: result upper equals: 1