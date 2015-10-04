accessing
testCreateDiagramElement
	self assert: diagramElement class equals: DCUmlLabel.
	self assert: diagramElement modelElement equals: method.
	self assert: diagramElement text equals: 'method()'.
	self deny: diagramElement style fontUnderline.
	self deny: diagramElement style fontItalic