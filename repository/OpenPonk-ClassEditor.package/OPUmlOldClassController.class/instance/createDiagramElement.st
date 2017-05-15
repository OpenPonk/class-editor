figures
createDiagramElement
	| el attributesCompartment operationsCompartment |
	el := OPUmlClassifierShape new.
	el sharedStyle fillColor: Color black.
	el modelElement: self model.
	nameLabel := OPUmlNameLabel new.
	nameLabel modelElement: self model.
	nameLabel text: self model name.
	nameLabel localStyle: (OPUmlStyle new fontSize: 11).
	nameLabel owningElement: el.
	attributesCompartment := OPUmlCompartment new.
	attributesCompartment owningElement: el.
	operationsCompartment := OPUmlCompartment new.
	operationsCompartment owningElement: el.
	^ el