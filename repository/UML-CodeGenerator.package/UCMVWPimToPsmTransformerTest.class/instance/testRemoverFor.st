tests - accessors
testRemoverFor
	input := FAMIXAttribute named: 'items'.
	input multiplicity upper: 2.
	result := transformer removerFor: input.
	self assert: result name equals: 'removeItem:'.
	self assert: result protocol equals: 'adding/removing'