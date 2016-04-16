tests
testAttributeMultiplicity
	| multiplicity |
	cls addInstVarNamed: #something.
	cls compile: 'something <DCType: #MyType multiplicity: #(2 10)> ^ something'.
	multiplicity := generator multiplicityFor: #something in: cls.
	self assert: multiplicity lower equals: 2.
	self assert: multiplicity upper equals: 10