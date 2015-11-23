tests
testInheritances
	self
		parse:
			'Sub << Super;
A extends B;'
		rule: #statements.
	self assert: result size equals: 2