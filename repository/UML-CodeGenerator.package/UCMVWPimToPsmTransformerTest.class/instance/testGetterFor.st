tests - accessors
testGetterFor
	input := FAMIXAttribute named: 'item'.
	result := transformer getterFor: input.
	self assert: result name equals: 'item'.
	self assert: result protocol equals: 'accessing'