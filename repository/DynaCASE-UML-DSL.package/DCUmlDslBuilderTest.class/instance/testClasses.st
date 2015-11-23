tests
testClasses
	self
		parse:
			'One {}
Two {}'
		rule: #statements.
	self assert: result size equals: 2.
	self assert: result first name equals: 'One'.
	self assert: result second name equals: 'Two'