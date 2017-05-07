figures
createDiagramElement
	^ OPUmlLabel new
		modelElement: self model;
		text: #name;
		localStyle: OPUmlStyle new;
		yourself