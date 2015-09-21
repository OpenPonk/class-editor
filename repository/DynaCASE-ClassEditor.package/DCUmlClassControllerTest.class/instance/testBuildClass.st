tests
testBuildClass
	| class |
	class := self newEmptyClass.
	controller model: class.
	controller attachTo: diagramController