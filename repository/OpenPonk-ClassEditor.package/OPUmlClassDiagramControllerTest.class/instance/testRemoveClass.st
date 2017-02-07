tests
testRemoveClass
	| class |
	class := FAMIXClass named: 'Something'.

	controller model add: class.
	controller rebuild.

	controller removeFromModel: class.
	self assert: controller controllers size equals: 0.
	self assert: controller model elements size equals: 0