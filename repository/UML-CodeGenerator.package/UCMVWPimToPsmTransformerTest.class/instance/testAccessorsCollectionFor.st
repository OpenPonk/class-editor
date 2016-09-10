tests
testAccessorsCollectionFor
	input := FAMIXAttribute named: 'items'.
	input multiplicity upper: 2.
	transformer context withAccessors.
	result := transformer accessorsFor: input.
	self assert: (result collect: #name) equals: #(items items: addItem: removeItem:)