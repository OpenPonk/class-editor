tests
testAssociationName
	true
		ifTrue: [ self skip ].
	super testAssociationName.
	self assert: result equals: 'name'