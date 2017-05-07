tests
testRemoveClassWithLinks
	| source target |
	source := FAMIXClass named: 'Source'.
	target := FAMIXClass named: 'Target'.
	controller model
		add: source;
		add: target;
		add: (FAMIXInheritance subclass: source superclass: target).
	controller rebuild.
	self assert: controller controllers size equals: 3.

	controller removeFromModel: source.
	self assert: controller controllers size equals: 1.
	self assert: controller model elements size equals: 1