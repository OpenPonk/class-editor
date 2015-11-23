tests
testAssociation
	true
		ifTrue: [ self skip ].
	self parse: 'Left --- Right' rule: #association