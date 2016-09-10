tests - accessors
testAdderFor
	input := FAMIXAttribute named: 'items'.
	input multiplicity upper: 2.
	result := transformer adderFor: input.
	self assert: result name equals: 'addItem:'.
	self assert: result protocol equals: 'adding/removing'