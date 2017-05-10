figures
createDiagramElement
	^ OPUmlLabel new
		modelElement: self model;
		text: [ :aModel | self attributeTextFor: aModel ];
		localStyle: OPUmlStyle new;
		yourself