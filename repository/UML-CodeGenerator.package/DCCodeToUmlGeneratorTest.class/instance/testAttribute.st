tests
testAttribute
	cls addInstVarNamed: #something.
	model := generator createAttributeNamed: #something in: cls.
	self assert: model class equals: FAMIXAttribute.
	self assert: model declaredType name equals: #Object