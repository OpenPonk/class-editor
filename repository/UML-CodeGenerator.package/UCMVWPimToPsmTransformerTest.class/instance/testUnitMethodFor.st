tests - meta
testUnitMethodFor
	input := FAMIXAttribute named: 'item'.
	result := transformer unitMethodFor: input.
	self assert: result name equals: 'item_unit'.
	self assert: result protocol equals: '+ parameter unit'.
	self assert: result isStatic