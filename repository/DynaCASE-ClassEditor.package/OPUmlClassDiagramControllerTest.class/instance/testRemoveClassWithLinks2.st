tests
testRemoveClassWithLinks2
	| source source2 target |
	source := FAMIXClass named: 'Source'.
	source2 := FAMIXClass named: 'Source2'.
	target := FAMIXClass named: 'Target'.
	controller model
		add: source;
		add: source2;
		add: target;
		add: (FAMIXInheritance subclass: source superclass: target);
		add: (FAMIXInheritance subclass: source2 superclass: target).
	controller rebuild.
	self assert: controller controllers size equals: 5.

	controller removeFromModel: target.
	self assert: controller controllers size equals: 2.
	self assert: controller model elements size equals: 2.
	self assert: target subInheritances isEmpty