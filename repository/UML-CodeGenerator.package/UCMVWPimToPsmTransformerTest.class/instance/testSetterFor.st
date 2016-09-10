tests - accessors
testSetterFor
	input := FAMIXAttribute named: 'item'.
	result := transformer setterFor: input.
	self assert: result name equals: 'item:'.
	self assert: result protocol equals: 'accessing'