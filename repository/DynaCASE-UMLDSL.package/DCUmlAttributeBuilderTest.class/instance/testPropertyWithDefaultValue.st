tests
testPropertyWithDefaultValue
	self parse: 'prop : Integer[4] = #(1 2 3 4)' rule: #property.
	self assert: result class equals: FAMIXAttribute.
	self assert: result name equals: 'prop'.
	self assert: result declaredType name equals: 'Integer'.
	self assert: result multiplicity lower equals: 4.
	self assert: result multiplicity upper equals: 4.
	self assert: result defaultValue valueExpression equals: '#(1 2 3 4)'