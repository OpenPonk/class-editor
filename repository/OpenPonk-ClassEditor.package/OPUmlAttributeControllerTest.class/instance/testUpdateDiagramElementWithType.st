accessing
testUpdateDiagramElementWithType
	attribute declaredType: (FAMIXClass named: 'String').
	controller refreshFigure.
	self assert: diagramElement text equals: 'attr : String'.

	attribute multiplicity upper: 5.
	controller refreshFigure.
	self assert: diagramElement text equals: 'attr : String[1..5]'