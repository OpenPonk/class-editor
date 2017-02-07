figures
createDiagramElement
	^ OPUmlLabel new
		modelElement: self model;
		text: self model name;
		owningElement: classController diagramElement compartments first;
		localStyle: DCUmlStyle new;
		yourself