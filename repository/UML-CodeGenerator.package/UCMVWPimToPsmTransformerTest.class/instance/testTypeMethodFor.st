tests - meta
testTypeMethodFor
	input := FAMIXAttribute named: 'item'.
	result := transformer typeMethodFor: input.
	self assert: result name equals: 'item_type'.
	self assert: result protocol equals: '+ parameter unit'.
	self assert: result isStatic