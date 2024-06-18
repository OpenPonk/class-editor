Class {
	#name : 'LUClassDiagramController',
	#superclass : 'OPUmlClassDiagramController',
	#category : 'LiveClassEditor-Controllers',
	#package : 'LiveClassEditor',
	#tag : 'Controllers'
}

{ #category : 'as yet unclassified' }
LUClassDiagramController >> initializePalette: aPalette [
	(aPalette newCreationEntry: [ LUCDClassController new ])
		label: 'Class';
		icon: OPUmlIcons current classIcon;
		whenCompleted: [ :ctrl | 
			OPRenameElementCommand executeOn: ctrl model.
			ctrl createClassFor: ctrl model.
			ctrl refreshFigure ].
	(aPalette newCreationEntry: [ LUCDAttributeController new ])
		label: 'Attribute';
		icon: Smalltalk ui theme icons abstractIcon;
		whenCompleted: [ :ctrl | 
			OPRenameElementCommand executeOn: ctrl model.
			ctrl createAttributeNamed: ctrl model name inClass: ctrl model parentType name.
			ctrl refreshFigure ].
	(aPalette newCreationEntry: [ LUCDMethodController new ])
		label: 'Method';
		icon: Smalltalk ui theme icons blankIcon;
		whenCompletedRename.
	(aPalette newConnectionCreationTool: [ OPUmlInheritanceController new ])
		label: 'Inheritance';
		icon: OPUmlIcons current generalizationIcon.
	(aPalette newConnectionCreationTool: [ OPUmlAssociationController new ])
		label: 'Association';
		icon: OPUmlIcons current associationIcon
]

{ #category : 'as yet unclassified' }
LUClassDiagramController >> modelToControllerMapping [
	^ {FAMIXClass -> LUCDClassController.
	FAMIXAttribute -> LUCDAttributeController.
	FAMIXMethod -> LUCDMethodController.
	OPFAMIXBinaryAssociation -> OPUmlAssociationController.
	FAMIXInheritance -> LUCDInheritanceController} asDictionary
]
