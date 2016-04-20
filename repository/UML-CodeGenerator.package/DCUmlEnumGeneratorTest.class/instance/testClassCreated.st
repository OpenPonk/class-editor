tests
testClassCreated
	self assert: cls name equals: model name.
	self assert: cls package name equals: model parentPackage name.
	self assert: cls superclass name equals: #Object