ui hooks
initializePalette: aPalette
	(aPalette newCreationEntry: [ OPUmlClassController new ])
		label: 'Class';
		icon: OPUmlIcons current classIcon;
		whenCompletedRename.
	(aPalette newCreationEntry: [ OPUmlAttributeController new ])
		label: 'Attribute';
		whenCompletedRename.
	(aPalette newCreationEntry: [ OPUmlOperationController new ])
		label: 'Operation';
		whenCompletedRename.
	(aPalette newConnectionCreationTool: [ OPUmlGeneralizationController new ])
		label: 'Generalization';
		icon: OPUmlIcons current generalizationIcon.
	(aPalette newConnectionCreationTool: [ OPUmlAssociationController new ])
		label: 'Association';
		icon: OPUmlIcons current associationIcon