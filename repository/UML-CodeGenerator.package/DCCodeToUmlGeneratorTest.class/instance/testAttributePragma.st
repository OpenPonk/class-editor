tests
testAttributePragma
	cls addInstVarNamed: #something.
	cls compile: 'something <DCType: #MyType multiplicity: #(2 10)> ^ something'.
	model := generator createAttributeNamed: #something in: cls.
	self assert: model declaredType name equals: #MyType.
	self assert: model multiplicity lower equals: 2.
	self assert: model multiplicity upper equals: 10