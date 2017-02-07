tests
testStatements
	self
		parse:
			'op1() : Type
attr
'
		rule: #statements.
	self assert: result size equals: 2.
	self assert: result first class equals: FAMIXMethod.
	self assert: result second class equals: FAMIXAttribute