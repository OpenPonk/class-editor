as yet unclassified
testParameterWithMultiplicity
	self parse: 'param : String[2..3]' rule: #parameter.
	self assert: result class equals: DCUmlParameter.
	self assert: result name equals: 'param'.
	self assert: result type equals: 'String'.
	self assert: result multiplicity lower equals: 2.
	self assert: result multiplicity upper equals: 3