tests
testRefreshFigure
	| class element nameLabel |
	class := self newEmptyClass.
	controller model: class.
	controller attachTo: diagramController.
	element := controller diagramElement.
	nameLabel := element ownedElements first.

	self assert: nameLabel text equals: class name.
	self deny: nameLabel style fontItalic.

	class name: 'New Name'.
	class isAbstract: true.
	controller refreshFigure.
	self assert: nameLabel text equals: 'New Name'.
	self assert: nameLabel style fontItalic