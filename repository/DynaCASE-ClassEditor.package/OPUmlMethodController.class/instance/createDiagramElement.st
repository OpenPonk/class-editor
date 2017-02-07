figures
createDiagramElement
	^ OPUmlLabel new
		modelElement: self model;
		text: self model name;
		owningElement: classController diagramElement compartments second;
		localStyle: DCUmlStyle new;
		yourself