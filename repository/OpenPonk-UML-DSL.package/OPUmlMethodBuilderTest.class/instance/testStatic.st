tests
testStatic
	self parse: '_op()' rule: #operation.
	self assert: result class equals: FAMIXMethod.
	self assert: result name equals: 'op'.
	self assert: result isStatic