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
	aPalette newSeparator.
	(aPalette newConnectionCreationTool: [ OPUmlGeneralizationController new ])
		label: 'Generalization';
		icon: OPUmlIcons current generalizationIcon.
	(aPalette newConnectionCreationTool: [ OPUmlAssociationController new ])
		label: 'Association';
		icon: OPUmlIcons current associationIcon.
	(aPalette newCreationEntry: [ OPUmlPackageController new beForPackage ])
		label: 'Package';
		whenCompletedRename.
	(aPalette newCreationEntry: [ OPUmlPackageController new beForModel ])
		label: 'Model';
		whenCompletedRename.
	(aPalette newCreationEntry: [ OPUmlPackageController new beForProfile ])
		label: 'Profile';
		whenCompletedRename.
	(aPalette newCreationEntry: [ OPUmlStereotypeController new ])
		label: 'Stereotype';
		whenCompletedRename.
	(aPalette newConnectionCreationTool: [ OPUmlExtensionController new ])
		label: 'Extension';
		icon: OPUmlIcons current associationIcon