figures
addAssociationEndFigures: anAssociationEnd at: aPosition
	| nameLabel multiplicityLabel |
	(nameLabel := DCUmlLabel new)
		modelElement: anAssociationEnd;
		text: (anAssociationEnd name ifNil: [ '' ]);
		owningElement: self diagramElement.
	constraints
		add:
			[ self constraintLabel: nameLabel rtElement toEdge: self figure at: aPosition ].
	(multiplicityLabel := DCUmlMultiplicityLabel new)
		modelElement: anAssociationEnd multiplicity;
		text: anAssociationEnd multiplicity printRange allButFirst allButLast;
		owningElement: self diagramElement.
	constraints
		add:
			[ self constraintLabel: multiplicityLabel rtElement toEdge: self figure at: aPosition ]