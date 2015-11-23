tests
testClass
	self parse: 'MyClass {}' rule: #classBlock.
	self assert: result class equals: FAMIXClass.
	self assert: result name equals: 'MyClass'.
	self deny: result isAbstract