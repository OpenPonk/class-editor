figures
addAssociationFigures
	| nameLabel |
	(nameLabel := OPUmlNameLabel new)
		modelElement: self model;
		text: self model name;
		owningElement: self diagramElement.
	constraints
		add:
			[ self constraintLabel: nameLabel rtElement toEdge: self figure at: #middle ].

	self addAssociationEndFigures: self model sourceEnd at: #end.
	self addAssociationEndFigures: self model targetEnd at: #start