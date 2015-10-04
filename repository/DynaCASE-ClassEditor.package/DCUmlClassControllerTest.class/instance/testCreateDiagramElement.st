tests
testCreateDiagramElement
	| class element owned |
	class := self newEmptyClass.
	controller model: class.

	element := controller createDiagramElement.
	self assert: element class equals: DCUmlClassifierShape.
	self assert: element modelElement equals: class.

	owned := element ownedElements.
	self assert: owned size equals: 3.
	self assert: owned first class equals: DCUmlNameLabel.
	self assert: owned first modelElement equals: class.
	self assert: owned first text equals: class name.
	self assert: owned second ownedElements isEmpty.
	self assert: owned third ownedElements isEmpty