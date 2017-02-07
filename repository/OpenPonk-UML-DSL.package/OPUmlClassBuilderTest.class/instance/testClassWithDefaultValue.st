tests
testClassWithDefaultValue
	self
		parse:
			'MyClass {
	attr : String = ''hello''
}'
		rule: #classBlock.
	self assert: result attributes size equals: 1.
	self assert: result attributes first name equals: 'attr'