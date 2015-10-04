accessing
testUpdateDiagramElementWithType
	method declaredType: (FAMIXClass named: 'String').
	controller refreshFigure.
	self assert: diagramElement text equals: 'method() : String'.

	method multiplicity upper: 5.
	controller refreshFigure.
	self assert: diagramElement text equals: 'method() : String[1..5]'