tests
testBuildClass
	| class |
	class := self newEmptyClass.
	controller model: class.
	controller attachTo: diagramController.
	self assert: diagramController controllers size equals: 1.
	self assert: diagramController controllers first equals: controller