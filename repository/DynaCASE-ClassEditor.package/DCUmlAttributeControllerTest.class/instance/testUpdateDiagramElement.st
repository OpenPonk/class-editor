accessing
testUpdateDiagramElement
	attribute name: 'newName'.
	controller refreshFigure.
	self assert: diagramElement text equals: 'newName'.

	self deny: diagramElement style fontUnderline.
	attribute isStatic: true.
	controller refreshFigure.
	self assert: diagramElement style fontUnderline.

	self deny: diagramElement style fontItalic.
	attribute isAbstract: true.
	controller refreshFigure.
	self assert: diagramElement style fontItalic