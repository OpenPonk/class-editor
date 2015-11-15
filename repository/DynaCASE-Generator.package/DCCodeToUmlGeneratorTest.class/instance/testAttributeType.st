tests
testAttributeType
	cls addInstVarNamed: #something.
	model := generator attributeTypeFor: #something in: cls.
	self assert: model class equals: FAMIXClass.
	self assert: model name equals: #Object