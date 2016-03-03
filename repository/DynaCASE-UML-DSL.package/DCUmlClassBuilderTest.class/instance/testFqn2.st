tests
testFqn2
	self parse: 'NS::MyClass' rule: #fqn.
	self assert: result equals: 'NS::MyClass'