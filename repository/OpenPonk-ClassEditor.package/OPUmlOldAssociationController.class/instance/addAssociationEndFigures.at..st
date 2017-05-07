figures
addAssociationEndFigures: anAssociationEnd at: aPosition
	| nameLabel multiplicityLabel |
	(nameLabel := OPUmlLabel new)
		modelElement: anAssociationEnd;
		text: (anAssociationEnd name ifNil: [ '' ]);
		owningElement: self diagramElement.
	constraints
		add:
			[ self
				constraintLabel: nameLabel rtElement
				toEdge: self figure
				at: aPosition
				side: 1 ].
	(multiplicityLabel := OPUmlMultiplicityLabel new)
		modelElement: anAssociationEnd multiplicity;
		text: anAssociationEnd multiplicity printRange allButFirst allButLast;
		owningElement: self diagramElement.
	constraints
		add:
			[ self
				constraintLabel: multiplicityLabel rtElement
				toEdge: self figure
				at: aPosition
				side: -1 ]