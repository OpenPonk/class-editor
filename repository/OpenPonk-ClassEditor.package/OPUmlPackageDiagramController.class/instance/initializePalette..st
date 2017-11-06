palette
initializePalette: aPalette
	(aPalette newCreationEntry: [ OPUmlClassController new ])
		label: 'Class';
		icon: OPUmlIcons classIcon;
		whenCompletedRename.
	(aPalette newCreationEntry: [ OPUmlAttributeController new ])
		label: 'Attribute';
		icon: OPUmlIcons attributeIcon;
		whenCompletedRename.
	(aPalette newCreationEntry: [ OPUmlOperationController new ])
		label: 'Operation';
		icon: OPUmlIcons operationIcon;
		whenCompletedRename.
	aPalette newSeparator.
	(aPalette newConnectionCreationTool: [ OPUmlAssociationController new ])
		label: 'Association';
		icon: OPUmlIcons directedAssociationIcon.
	(aPalette newConnectionCreationTool: [ OPUmlGeneralizationController new ])
		label: 'Generalization';
		icon: OPUmlIcons generalizationIcon.
	aPalette newSeparator.
	(aPalette newCreationEntry: [ OPUmlEnumerationController new ])
		label: 'Enumeration';
		icon: OPUmlIcons enumIcon;
		whenCompletedRename.
	(aPalette newCreationEntry: [ OPUmlEnumerationLiteralController new ])
		label: 'Enumeration Literal';
		icon: OPUmlIcons literalIcon;
		whenCompletedRename.
	(self model oclIsKindOf: #Profile)
		ifTrue: [ aPalette newSeparator.
			(aPalette newCreationEntry: [ OPUmlStereotypeController new ])
				label: 'Stereotype';
				icon: OPUmlIcons stereotypeIcon;
				whenCompletedRename.
			(aPalette newConnectionCreationTool: [ OPUmlExtensionController new ])
				label: 'Extension';
				icon: OPUmlIcons extensionIcon ].
	self initializeProfilePalette: aPalette