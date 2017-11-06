palette
initializeProfilePalette: aPalette
	| profile stereotypes elements relationships isForRelationship |
	model profileApplications ifEmpty: [ ^ self ].
	profile := model profileApplications first appliedProfile.
	stereotypes := (profile ownedStereotype reject: #isAbstract)
		sorted: [ :a :b | a name < b name ].
	isForRelationship := [ :attr | 
	(OPUMLXMISpecsStorage metaClassNamed: attr type name) allParents
		anySatisfy: [ :parent | parent name = 'Relationship' ] ].
	elements := stereotypes
		select: [ :each | 
			each allAttributes
				anySatisfy: [ :attr | (attr name beginsWith: 'base_') and: [ (isForRelationship value: attr) not ] ] ].
	relationships := stereotypes
		select: [ :each | 
			each allAttributes
				anySatisfy: [ :attr | (attr name beginsWith: 'base_') and: [ isForRelationship value: attr ] ] ].
	aPalette newSeparator.
	elements
		do: [ :stereotype | 
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
	relationships
		do: [ :stereotype | 
			(aPalette newConnectionCreationEntry: [ OPUmlAssociationController new ])
				label: stereotype name;
				icon: OPUmlIcons directedAssociationIcon;
				whenCompleted: [ :ctrl | 
					ctrl model applyStereotype: stereotype implementationClass new.
					ctrl refreshFigure ] ]