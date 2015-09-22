tests
testBuildClassWithAttributes
	| class |
	class := self newClassWithAttributes.
	controller model: class.
	controller attachTo: diagramController.
	self assert: diagramController controllers size equals: 3