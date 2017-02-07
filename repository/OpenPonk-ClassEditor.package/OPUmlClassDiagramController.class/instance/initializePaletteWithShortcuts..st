ui hooks
initializePaletteWithShortcuts: aPalette
	(aPalette newCreationTool: [ OPUmlClassController new ])
		label: 'Class';
		shortcut: $c asShortcut;
		icon: OPUmlIcons current classIcon.
	(aPalette newConnectionCreationTool: [ OPUmlInheritanceController new ])
		label: 'Generalization';
		shortcut: $g asShortcut;
		icon: OPUmlIcons current generalizationIcon.
	(aPalette newConnectionCreationTool: [ OPUmlAssociationController new ])
		label: 'Association';
		shortcut: $a asShortcut;
		icon: OPUmlIcons current associationIcon