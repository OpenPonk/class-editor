ui hooks
initializePalette: aPalette
	(aPalette newCreationTool: [ DCUmlClassController new ])
		label: 'Class';
		icon: DCUmlIcons current classIcon.
	(aPalette newCreationTool: [DCUmlAttributeController new])
		label: 'Attribute';
		icon: Smalltalk ui theme icons abstractIcon.
	(aPalette newConnectionCreationTool: [ DCUmlGeneralizationController new ])
		label: 'Generalization';
		icon: DCUmlIcons current generalizationIcon.
	(aPalette newConnectionCreationTool: [ DCUmlAssociationController new ])
		label: 'Association';
		icon: DCUmlIcons current associationIcon