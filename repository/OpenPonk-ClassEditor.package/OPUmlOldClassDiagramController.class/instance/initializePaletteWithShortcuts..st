ui hooks
initializePaletteWithShortcuts: aPalette
	(aPalette newCreationTool: [ OPUmlOldClassController new ])
		label: 'Class';
		shortcut: $c asShortcut;
		icon: OPUmlIcons current classIcon.
	(aPalette newConnectionCreationTool: [ OPUmlOldInheritanceController new ])
		label: 'Generalization';
		shortcut: $g asShortcut;
		icon: OPUmlIcons current generalizationIcon.
	(aPalette newConnectionCreationTool: [ OPUmlOldAssociationController new ])
		label: 'Association';
		shortcut: $a asShortcut;
		icon: OPUmlIcons current associationIcon