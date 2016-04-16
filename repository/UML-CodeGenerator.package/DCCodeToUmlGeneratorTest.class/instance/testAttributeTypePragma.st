tests
testAttributeTypePragma
	cls addInstVarNamed: #something.
	cls compile: 'something <DCType: #MyType multiplicity: #(2 10)> ^ something'.
	self assert: (generator attributeTypeNameFor: #something in: cls) equals: #MyType