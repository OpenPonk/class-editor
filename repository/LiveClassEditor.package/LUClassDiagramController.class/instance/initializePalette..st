as yet unclassified
initializePalette: aPalette
	(aPalette newCreationEntry: [ LUCDClassController new ])
		label: 'Class';
		icon: DCUmlIcons current classIcon;
		whenCompleted: [ :ctrl | 
			DCRenameElementCommand executeOn: ctrl model.
			ctrl createClassFor: ctrl model.
			ctrl refreshFigure ].
	(aPalette newCreationEntry: [ LUCDAttributeController new ])
		label: 'Attribute';
		icon: Smalltalk ui theme icons abstractIcon;
		whenCompleted: [ :ctrl | 
			DCRenameElementCommand executeOn: ctrl model.
			ctrl createAttributeNamed: ctrl model name inClass: ctrl model parentType name.
			ctrl refreshFigure ].
	(aPalette newCreationEntry: [ LUCDMethodController new ])
		label: 'Method';
		icon: Smalltalk ui theme icons blankIcon;
		whenCompletedRename.
	(aPalette newConnectionCreationTool: [ DCUmlInheritanceController new ])
		label: 'Inheritance';
		icon: DCUmlIcons current generalizationIcon.
	(aPalette newConnectionCreationTool: [ DCUmlAssociationController new ])
		label: 'Association';
		icon: DCUmlIcons current associationIcon