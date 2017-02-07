tests
testStatements2
	self parse: '' rule: #statements.
	self assert: result size equals: 0