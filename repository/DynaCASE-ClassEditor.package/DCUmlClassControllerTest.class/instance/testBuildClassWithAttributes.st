tests
testBuildClassWithAttributes
	| class |
	class := self newClassWithAttributes.
	controller model: class.
	controller attachTo: diagramController