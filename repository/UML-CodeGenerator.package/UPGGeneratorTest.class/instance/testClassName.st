tests
testClassName
	self assert: (generator classNameFor: 'MyObject') equals: 'MyObject'.
	self assert: (generator classNameFor: 'Object') equals: 'Object'.