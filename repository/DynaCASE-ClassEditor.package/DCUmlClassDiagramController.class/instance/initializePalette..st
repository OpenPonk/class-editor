ui hooks
initializePalette: aPalette
	(aPalette newCreationTool: [ DCUmlClassController new ])
		label: 'Class';
		icon: DCUmlIcons current classIcon.
	(aPalette newCreationTool: [ DCUmlAttributeController new ])
		label: 'Attribute';
		icon: Smalltalk ui theme icons abstractIcon.
	(aPalette newCreationTool: [ DCUmlMethodController new ])
		label: 'Method';
		icon: Smalltalk ui theme icons blankIcon.
	(aPalette newConnectionCreationTool: [ DCUmlInheritanceController new ])
		label: 'Inheritance';
		icon: DCUmlIcons current generalizationIcon.
	(aPalette newConnectionCreationTool: [ DCUmlAssociationController new ])
		label: 'Association';
		icon: DCUmlIcons current associationIcon