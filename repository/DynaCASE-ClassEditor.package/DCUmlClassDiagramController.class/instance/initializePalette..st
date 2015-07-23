ui hooks
initializePalette: aPalette
	aPalette
		newCreationTool: 'Class' factory: [ DCUmlClassController new ] icon: DCUmlIcons current diagramIcon;
		newConnectionCreationTool: 'Generalization'
			factory: [ DCUmlGeneralizationController new ]
			icon: DCUmlIcons current generalizationIcon;
		newConnectionCreationTool: 'Association'
			factory: [ DCUmlAssociationController new ]
			icon: DCUmlIcons current associationIcon