tests
testMethod
	cls compile: 'method ^ 1'.
	model := generator createMethodFor: #method in: cls.
	self assert: model class equals: FAMIXMethod.
	self assert: model name equals: #method