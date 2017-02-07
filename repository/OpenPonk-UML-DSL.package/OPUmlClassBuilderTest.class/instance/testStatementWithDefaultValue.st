tests
testStatementWithDefaultValue
	self parse: 'attr : String = ''hello''
' rule: #statements.
	self assert: result size equals: 1.
	self assert: result first name equals: 'attr'