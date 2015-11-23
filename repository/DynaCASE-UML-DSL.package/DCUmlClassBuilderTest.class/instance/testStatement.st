tests
testStatement
	self parse: 'attr : Type' rule: #statement.
	self assert: result class equals: FAMIXAttribute.
	self assert: result name equals: 'attr'