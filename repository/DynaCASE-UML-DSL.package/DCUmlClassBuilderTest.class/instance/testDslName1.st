tests
testDslName1
	self parse: '/MyClass/' rule: #dslName.
	self assert: result equals: #('MyClass' true)