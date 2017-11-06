palette
initializePackagePalette: aPalette
	(aPalette newCreationEntry: [ OPUmlPackageController new beForPackage ])
		label: 'Package';
		icon: OPUmlIcons packageIcon;
		whenCompletedRename.
	(aPalette newCreationEntry: [ OPUmlPackageController new beForModel ])
		label: 'Model';
		icon: OPUmlIcons modelIcon;
		whenCompletedRename.
	aPalette newSeparator.
	(aPalette newCreationEntry: [ OPUmlPackageController new beForProfile ])
		label: 'Profile';
		icon: OPUmlIcons profileIcon;
		whenCompletedRename