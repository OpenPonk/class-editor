tests
testFqn1
	self parse: '::MyClass' rule: #fqn.
	self assert: result equals: '::MyClass'