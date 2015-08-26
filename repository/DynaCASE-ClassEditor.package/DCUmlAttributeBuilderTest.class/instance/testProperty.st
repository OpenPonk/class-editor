tests
testProperty
	self parse: 'prop' rule: #property.
	self assert: result class equals: DCUmlAttribute.
	self assert: result name equals: 'prop'.
	self assert: result type equals: nil.
	self assert: result multiplicity lower equals: 1.
	self assert: result multiplicity upper equals: 1