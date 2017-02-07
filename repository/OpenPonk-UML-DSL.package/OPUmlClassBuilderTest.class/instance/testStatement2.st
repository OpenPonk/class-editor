tests
testStatement2
	self parse: 'op()' rule: #statement.
	self assert: result class equals: FAMIXMethod.
	self assert: result name equals: 'op'