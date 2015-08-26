tests
testOperation
	self parse: 'op()' rule: #operation.
	self assert: result class equals: DCUmlOperation.
	self assert: result name equals: 'op'.
	self assert: result parameters size equals: 0.
	self assert: result returnParameter equals: nil