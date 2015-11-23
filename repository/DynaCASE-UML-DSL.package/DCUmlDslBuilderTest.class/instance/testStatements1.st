tests
testStatements1
	self
		parse:
			'Left --- Right;
Source --> Target : z;
Class { }
Source --> Target : z;
Person {
	name : String
}
'
		rule: #statements.
	self assert: result size equals: 5