tests
testDefaultValue
	self parse: '= 10' rule: #defaultValue.
	self assert: result class equals: DCFAMIXValueSpecification.
	self assert: result valueExpression equals: '10'