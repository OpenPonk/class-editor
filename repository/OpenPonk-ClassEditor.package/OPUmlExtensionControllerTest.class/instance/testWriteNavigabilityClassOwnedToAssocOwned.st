tests
testWriteNavigabilityClassOwnedToAssocOwned
	| first |
	first := extension memberEnds first.
	controller writeNavigability: false to: first.
	self deny: first isNavigable.
	self assert: first owningClass equals: nil.
	self assert: first owningAssociation equals: extension