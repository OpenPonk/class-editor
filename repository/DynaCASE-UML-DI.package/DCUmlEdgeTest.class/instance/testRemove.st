tests
testRemove
	| lbl |
	(lbl := DCUmlLabel new) owningElement: element.
	self assert: element ownedElements asArray equals: {lbl}.
	lbl owningElement: nil.
	self assert: element ownedElements isEmpty