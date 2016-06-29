tests
testClassNameAlwaysPrefixed
	generator context prefix: 'XX'.
	generator context alwaysUsePrefix.
	self assert: (generator classNameFor: 'MyObject') equals: 'XXMyObject'.
	self assert: (generator classNameFor: 'Object') equals: 'XXObject'