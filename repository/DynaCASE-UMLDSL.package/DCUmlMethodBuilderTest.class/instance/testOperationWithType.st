tests
testOperationWithType
	self parse: 'op(): String' rule: #operation.
	self assert: result declaredType name equals: 'String'.
	self assert: result multiplicity lower equals: 1.
	self assert: result multiplicity upper equals: 1