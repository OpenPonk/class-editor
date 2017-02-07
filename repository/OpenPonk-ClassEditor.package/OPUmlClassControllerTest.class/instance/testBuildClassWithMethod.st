tests
testBuildClassWithMethod
	| class |
	class := self newClassWithMethod.
	controller model: class.
	controller attachTo: diagramController.
	self assert: diagramController controllers size equals: 2.
	self assert: diagramController controllers second model equals: class methods first