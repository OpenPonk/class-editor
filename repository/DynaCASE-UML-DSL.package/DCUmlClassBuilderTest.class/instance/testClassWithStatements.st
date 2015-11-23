tests
testClassWithStatements
	self
		parse:
			'MyClass {
	attr : String
	op() : Integer
}'
		rule: #classBlock.
	self assert: result attributes size equals: 1.
	self assert: result attributes first name equals: 'attr'.
	self assert: result methods size equals: 1.
	self assert: result methods first name equals: 'op'