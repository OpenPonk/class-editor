tests
testBuildClass
	| class cc |
	class := FAMIXClass named: 'Something'.
	controller model add: class.
	self assert: controller controllers size equals: 0.
	controller rebuild.
	self assert: controller controllers size equals: 1.
	cc := controller controllers first.
	self assert: cc class equals: OPUmlOldClassController.
	self assert: cc model equals: class.
	self assert: controller model elements size equals: 1