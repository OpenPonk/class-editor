tests
testRemoveAttribute
	| class moose |
	moose := MooseModel new.
	class := FAMIXClass named: 'Something'.
	moose add: class.
	class addAttribute: (FAMIXAttribute named: 'attribute1').
	controller model: class.
	controller attachTo: diagramController.

	self assert: class attributes size equals: 1.
	diagramController removeFromModel: class attributes first.
	self assert: class attributes size equals: 0.
	self assert: diagramController controllers size equals: 1.
	self assert: diagramController model allAttributes size equals: 0