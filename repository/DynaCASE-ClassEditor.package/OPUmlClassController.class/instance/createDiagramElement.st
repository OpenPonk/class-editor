figures
createDiagramElement
	| el attributesCompartment operationsCompartment |
	el := DCUmlClassifierShape new.
	el sharedStyle fillColor: Color white.
	el modelElement: self model.
	nameLabel := DCUmlNameLabel new.
	nameLabel modelElement: self model.
	nameLabel text: self model name.
	nameLabel localStyle: (DCUmlStyle new fontSize: 11).
	nameLabel owningElement: el.
	attributesCompartment := OPUmlCompartment new.
	attributesCompartment owningElement: el.
	operationsCompartment := OPUmlCompartment new.
	operationsCompartment owningElement: el.
	^ el