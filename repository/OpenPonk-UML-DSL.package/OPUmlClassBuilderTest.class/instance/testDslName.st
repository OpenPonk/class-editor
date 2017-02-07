tests
testDslName
	self parse: 'MyClass' rule: #dslName.
	self assert: result equals: #(false 'MyClass')