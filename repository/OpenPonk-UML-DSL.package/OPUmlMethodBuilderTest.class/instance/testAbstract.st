tests
testAbstract
	self parse: '/op()' rule: #operation.
	self assert: result isAbstract