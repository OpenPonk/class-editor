tests
testPropertyWithType
	self parse: 'prop: String' rule: #property.
	self assert: result class equals: FAMIXAttribute.
	self assert: result name equals: 'prop'.
	self assert: result declaredType name equals: 'String'.
	self assert: result multiplicity lower equals: 1.
	self assert: result multiplicity upper equals: 1