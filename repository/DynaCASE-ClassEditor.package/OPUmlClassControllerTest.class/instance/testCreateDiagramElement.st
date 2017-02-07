tests
testCreateDiagramElement
	| class element owned |
	class := self newEmptyClass.
	controller model: class.
	controller attachTo: diagramController.

	element := controller diagramElement.
	self assert: element class equals: OPUmlClassifierShape.
	self assert: element modelElement equals: class.

	owned := element ownedElements.
	self assert: owned size equals: 3.
	self assert: owned first class equals: OPUmlNameLabel.
	self assert: owned first modelElement equals: class.
	self assert: owned first text equals: class name.
	self deny: owned first style fontItalic.
	self assert: owned second ownedElements isEmpty.
	self assert: owned third ownedElements isEmpty