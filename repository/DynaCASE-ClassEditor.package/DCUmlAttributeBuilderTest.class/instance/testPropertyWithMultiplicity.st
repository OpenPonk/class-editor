tests
testPropertyWithMultiplicity
	self parse: 'prop: String[2..3]' rule: #property.
	self assert: result class equals: DCUmlAttribute.
	self assert: result name equals: 'prop'.
	self assert: result type equals: 'String'.
	self assert: result multiplicity lower equals: 2.
	self assert: result multiplicity upper equals: 3