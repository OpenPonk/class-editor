tests - meta
testDefaultMethodFor
	(input := FAMIXAttribute named: 'item')
		defaultValue: (DCFAMIXValueSpecification from: '15').
	result := transformer defaultMethodFor: input.
	self assert: result name equals: 'item_default'.
	self assert: result protocol equals: '- default value'.
	self assert: result isStatic