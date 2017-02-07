accessing
testUpdateDiagramElementWithReturn
	method
		addParameter:
			((FAMIXParameter named: 'return' type: (FAMIXClass named: 'String'))
				direction: OPUmlParameterDirectionKind return).
	controller refreshFigure.
	self assert: diagramElement text equals: 'method() : String'.
	method parameters first multiplicity upper: 5.
	controller refreshFigure.
	self assert: diagramElement text equals: 'method() : String[1..5]'