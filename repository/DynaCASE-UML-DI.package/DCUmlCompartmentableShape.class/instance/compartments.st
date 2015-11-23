accessing
compartments
	<DCType: #DCUmlCompartment opposite: #compartmentedShape multiplicity: #(#*)>
	^ self ownedElements select: [ :each | each isKindOf: DCUmlCompartment ]