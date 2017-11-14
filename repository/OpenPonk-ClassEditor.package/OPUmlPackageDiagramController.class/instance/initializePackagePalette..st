palette
initializePackagePalette: aPalette
	aPalette newSeparator.
	(aPalette newCreationEntry: [ OPUmlPackageController new beForPackage ])
		label: 'Package';
		icon: OPUmlIcons packageIcon;
		whenCompletedRename.
	(aPalette newCreationEntry: [ OPUmlPackageController new beForModel ])
		label: 'Model';
		icon: OPUmlIcons modelIcon;
		whenCompletedRename.
	(aPalette newConnectionCreationTool: [ OPUmlPackageImportController new ])
		label: 'Package Import';
		icon: OPUmlIcons directedAssociationIcon.
	(aPalette newCreationEntry: [ OPUmlPackageController new beForProfile ])
		label: 'Profile';
		icon: OPUmlIcons profileIcon;
		whenCompletedRename