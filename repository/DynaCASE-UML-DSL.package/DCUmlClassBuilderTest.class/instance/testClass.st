tests
testClass
	self parse: 'MyClass' rule: #famixClass.
	self assert: result class equals: FAMIXClass.
	self assert: result name equals: 'MyClass'.
	self deny: result isAbstract