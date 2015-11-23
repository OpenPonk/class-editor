tests
testStatements1
	true
		ifTrue: [ self skip ].
	self
		parse:
			'Left --- Right
Source --> Target : z

'
		rule: #statements.
	self assert: result size equals: 2