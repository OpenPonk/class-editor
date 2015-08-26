tests
testOperationWithMultiplicity
	self parse: 'op(): String[2..*]' rule: #operation.
	self assert: result returnParameter type equals: 'String'.
	self assert: result returnParameter multiplicity lower equals: 2.
	self assert: result returnParameter multiplicity upper equals: Float infinity.