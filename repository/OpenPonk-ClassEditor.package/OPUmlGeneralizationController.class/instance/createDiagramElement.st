figures
createDiagramElement
	^ OPUmlEdge new
		modelElement: self model;
		headDecorator: RTEmptyNarrowArrow;
		in: [ :e | e localStyle strokeColor: Color white ];
		yourself