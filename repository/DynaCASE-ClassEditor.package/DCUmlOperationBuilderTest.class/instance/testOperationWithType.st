tests
testOperationWithType
	self parse: 'op(): String' rule: #operation.
	self assert: result returnParameter type equals: 'String'.
	self assert: result returnParameter multiplicity lower equals: 1.
	self assert: result returnParameter multiplicity upper equals: 1