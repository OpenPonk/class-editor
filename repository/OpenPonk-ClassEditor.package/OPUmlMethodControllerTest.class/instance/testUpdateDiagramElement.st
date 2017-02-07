accessing
testUpdateDiagramElement
	method name: 'newName'.
	controller refreshFigure.
	self assert: diagramElement text equals: 'newName()'.

	self deny: diagramElement style fontUnderline.
	method isStatic: true.
	controller refreshFigure.
	self assert: diagramElement style fontUnderline.

	self deny: diagramElement style fontItalic.
	method isAbstract: true.
	controller refreshFigure.
	self assert: diagramElement style fontItalic