ui hooks
initializePalette: aPalette
	(aPalette newModelCreationTool: [ OPUmlClassController new ])
		label: 'Class';
		icon: OPUmlIcons current classIcon