figures
createDiagramElement
	^ OPUmlGeneralizationShape new
		modelElement: self model;
		in: [ :e | e localStyle strokeColor: Color white ];
		yourself