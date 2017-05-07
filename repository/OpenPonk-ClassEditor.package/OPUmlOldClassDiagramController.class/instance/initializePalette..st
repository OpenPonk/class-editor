ui hooks
initializePalette: aPalette
	(aPalette newCreationEntry: [ OPUmlOldClassController new ])
		label: 'Class';
		icon: OPUmlIcons current classIcon;
		whenCompleted: [ :ctrl | 
			OPRenameElementCommand executeOn: ctrl model.
			ctrl refreshFigure ].
	(aPalette newCreationEntry: [ OPUmlOldAttributeController new ])
		label: 'Attribute';
		icon: Smalltalk ui theme icons abstractIcon;
		whenCompletedRename.
	(aPalette newCreationEntry: [ OPUmlOldMethodController new ])
		label: 'Method';
		icon: Smalltalk ui theme icons blankIcon;
		whenCompletedRename.
	(aPalette newConnectionCreationTool: [ OPUmlOldInheritanceController new ])
		label: 'Inheritance';
		icon: OPUmlIcons current generalizationIcon.
	(aPalette newConnectionCreationTool: [ OPUmlOldAssociationController new ])
		label: 'Association';
		icon: OPUmlIcons current associationIcon