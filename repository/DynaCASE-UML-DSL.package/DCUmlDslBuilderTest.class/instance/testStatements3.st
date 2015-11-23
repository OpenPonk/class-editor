tests
testStatements3
	self parse: '
Class { }' rule: #statements.
	self assert: result size equals: 1