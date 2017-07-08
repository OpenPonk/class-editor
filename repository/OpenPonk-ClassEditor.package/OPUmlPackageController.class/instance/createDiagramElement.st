figures
createDiagramElement
	^ OPUmlPackageCompartmentableShape new
		modelElement: self model;
		in: [ :shape | 
			shape style
				fillColor: Color veryVeryDarkGray;
				fontColor: Color black ];
		yourself