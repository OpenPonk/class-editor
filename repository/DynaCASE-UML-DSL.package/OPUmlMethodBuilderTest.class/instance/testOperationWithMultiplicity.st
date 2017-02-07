tests
testOperationWithMultiplicity
	self parse: 'op(): String[2..*]' rule: #operation.
	self assert: result declaredType name equals: 'String'.
	self assert: result multiplicity lower equals: 2.
	self assert: result multiplicity upper equals: OPUnlimitedNatural max