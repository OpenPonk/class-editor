tests
testWriteNavigabilityAssocOwnedToClassOwned
	| first second |
	first := extension memberEnds first.
	second := extension memberEnds second.
	controller writeNavigability: true to: second.
	self assert: second isNavigable.
	self assert: second owningClass equals: first type