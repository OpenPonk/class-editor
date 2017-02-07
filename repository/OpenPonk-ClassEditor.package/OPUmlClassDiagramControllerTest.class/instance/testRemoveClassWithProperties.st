tests
testRemoveClassWithProperties
	| class |
	class := FAMIXClass named: 'Something'.
	class addAttribute: (FAMIXAttribute named: 'Whatever').
	controller model add: class.
	controller rebuild.
	self assert: controller controllers size equals: 2.

	controller removeFromModel: class.
	self assert: controller controllers size equals: 0.
	self assert: controller model elements size equals: 0