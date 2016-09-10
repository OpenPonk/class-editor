tests - accessors
testSetterSourceFor
	input := FAMIXAttribute named: 'item'.
	result := transformer setterSourceFor: input.
	self
		assert: result body
		equals:
			'item: anObject
	item = anObject ifTrue: [ ^ self ]. "for optimization"
	item := anObject.
	self changed'