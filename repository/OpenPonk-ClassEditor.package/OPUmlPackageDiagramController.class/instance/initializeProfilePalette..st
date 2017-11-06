palette
initializeProfilePalette: aPalette
	| profile stereotypes |
	model profileApplications ifEmpty: [ ^ self ].
	profile := model profileApplications first appliedProfile.
	stereotypes := (profile ownedStereotype reject: #isAbstract) sorted: [ :a :b | a name < b name ].
	aPalette newSeparator.
	stereotypes
		select: [ :each | each allAttributes anySatisfy: [ :attr | attr name = 'base_Class' ] ]
		thenDo: [ :stereotype | 
			(aPalette newCreationEntry: [ OPUmlClassController new ])
				label: stereotype name;
				icon: OPUmlIcons classIcon;
				whenCompleted: [ :ctrl | 
					ctrl model applyStereotype: stereotype implementationClass new.
					ctrl model name: stereotype name.
					ctrl refreshFigure.
					OPRenameElementCommand executeOn: ctrl model.
					ctrl refreshFigure ] ].
	aPalette newSeparator.
	stereotypes
		select: [ :each | each allAttributes anySatisfy: [ :attr | attr name = 'base_Association' ] ]
		thenDo: [ :stereotype | 
			(aPalette newConnectionCreationEntry: [ OPUmlAssociationController new ])
				label: stereotype name;
				icon: OPUmlIcons directedAssociationIcon;
				whenCompleted: [ :ctrl | 
					ctrl model applyStereotype: stereotype implementationClass new.
					ctrl refreshFigure ] ]