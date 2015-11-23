tests
testStatements1
	self
		parse:
			'Left --- Right
Source --> Target : z

'
		rule: #statements.
	self assert: result size equals: 2