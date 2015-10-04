accessing
testCreateDiagramElement
	self assert: diagramElement class equals: DCUmlLabel.
	self assert: diagramElement modelElement equals: attribute.
	self assert: diagramElement text equals: 'attr'.
	self deny: diagramElement style fontUnderline.
	self deny: diagramElement style fontItalic