tests
testParameter
	self parse: 'param : String' rule: #parameter.
	self assert: result class equals: DCUmlParameter.
	self assert: result name equals: 'param'.
	self assert: result type equals: 'String'.
	self assert: result multiplicity lower equals: 1.
	self assert: result multiplicity upper equals: 1