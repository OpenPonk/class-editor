tests
testRemoveMethod
	| class |
	class := self newClassWithMethod.
	controller model: class.
	controller attachTo: diagramController.

	self assert: class methods size equals: 1.
	diagramController removeFromModel: class methods first.
	self assert: class methods size equals: 0.
	self assert: diagramController controllers size equals: 1