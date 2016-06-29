tests
testClassNamePrefixed
	generator context prefix: 'XX'.
	self assert: (generator classNameFor: 'MyObject') equals: 'XXMyObject'.
	self assert: (generator classNameFor: 'Object') equals: 'Object'