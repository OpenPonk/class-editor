tests
testDefaultValue
	self parse: '= 10' rule: #defaultValue.
	self assert: result class equals: OPFAMIXValueSpecification.
	self assert: result valueExpression equals: '10'