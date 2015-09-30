tests
testAddClassController
	| cc |
	self assert: controller controllers size equals: 0.
	self assert: controller model elements size equals: 0.
	cc := DCUmlClassController new.
	self assert: (controller canBeTargetFor: cc).
	controller addAsTargetFor: cc.
	self assert: controller controllers size equals: 1.
	self assert: controller model elements size equals: 1.
	self assert: (controller controllers includes: cc).
	self assert: controller model elements first equals: cc model.
	self assert: controller model elements first name equals: 'Class'