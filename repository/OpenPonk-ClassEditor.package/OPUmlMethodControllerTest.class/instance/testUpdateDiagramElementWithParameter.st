accessing
testUpdateDiagramElementWithParameter
	method addParameter: (FAMIXParameter named: 'param' type: (FAMIXClass named: 'Number')).
	controller refreshFigure.
	self assert: diagramElement text equals: 'method(param : Number)'