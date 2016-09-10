tests - accessors
testSetterMultipleSourceFor
	input := FAMIXAttribute named: 'item'.
	input multiplicity upper: 2.
	result := transformer setterSourceFor: input.
	self
		assert: result source
		equals:
			'item: aCollection
	item = aCollection ifTrue: [ ^ self ]. "for optimization"
	item := aCollection.
	self changed'