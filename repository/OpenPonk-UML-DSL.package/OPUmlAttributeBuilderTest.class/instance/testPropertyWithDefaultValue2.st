tests
testPropertyWithDefaultValue2
	self parse: 'attr : String = ''hello''' rule: #property.
	self assert: result class equals: FAMIXAttribute.
	self assert: result name equals: 'attr'.
	self assert: result declaredType name equals: 'String'.
	self assert: result multiplicity lower equals: 1.
	self assert: result multiplicity upper equals: 1.
	self assert: result defaultValue valueExpression equals: '''hello'''