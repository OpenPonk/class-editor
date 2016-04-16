tests
testAttributeTypeDefault
	cls addInstVarNamed: #something.
	self assert: (generator attributeTypeNameFor: #something in: cls) equals: #Object