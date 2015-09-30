tests
testAbstractClass
	self parse: '/MyClass/' rule: #famixClass.
	self assert: result class equals: FAMIXClass.
	self assert: result name equals: 'MyClass'.
	self assert: result isAbstract