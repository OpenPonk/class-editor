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
		whenCompletedRename