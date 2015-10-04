figures
createDiagramElement
	| el attributesCompartment operationsCompartment |
	el := DCUmlClassifierShape new.
	el modelElement: self model.

	nameLabel := DCUmlNameLabel new.
	nameLabel modelElement: self model.
	nameLabel text: self model name.
	nameLabel localStyle: (DCUmlStyle new fontSize: 11).
	nameLabel owningElement: el.

	attributesCompartment := DCUmlCompartment new.
	attributesCompartment owningElement: el.

	operationsCompartment := DCUmlCompartment new.
	operationsCompartment owningElement: el.

	^ el