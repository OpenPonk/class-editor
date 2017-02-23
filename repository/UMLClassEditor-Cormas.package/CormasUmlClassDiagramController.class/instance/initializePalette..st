as yet unclassified
initializePalette: aPalette
	(aPalette newCreationEntry: [ OPUmlClassController new ])
		label: 'Class';
		icon: OPUmlIcons current classIcon;
		whenCompleted: [ :ctrl | 
			OPRenameElementCommand executeOn: ctrl model.
			ctrl refreshFigure.
			self model isCormasModel
				ifTrue: [ ctrl addAutomaticCormasAssociation ] ].
	(aPalette newCreationEntry: [ OPUmlAttributeController new ])
		label: 'Attribute';
		icon: Smalltalk ui theme icons abstractIcon;
		whenCompletedRename.
	(aPalette newCreationEntry: [ OPUmlMethodController new ])
		label: 'Method';
		icon: Smalltalk ui theme icons blankIcon;
		whenCompletedRename.
	(aPalette newConnectionCreationTool: [ OPUmlInheritanceController new ])
		label: 'Inheritance';
		icon: OPUmlIcons current generalizationIcon.
	(aPalette newConnectionCreationTool: [ OPUmlAssociationController new ])
		label: 'Association';
		icon: OPUmlIcons current associationIcon