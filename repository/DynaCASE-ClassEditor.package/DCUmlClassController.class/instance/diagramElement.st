figures
diagramElement
	diagramElement
		ifNil:
			[ diagramElement := self createDiagramElement renderIn: self diagramController view ].
	^ diagramElement