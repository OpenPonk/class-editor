Class {
	#name : #CormasUmlClassDiagramController,
	#superclass : #Object,
	#category : #'UMLClassEditor-Cormas-Controllers'
}

{ #category : #initialization }
CormasUmlClassDiagramController >> initializePalette: aPalette [
	(aPalette newCreationEntry: [ OPUmlClassController new ])
		label: 'Class';
		icon: OPUmlIcons classIcon;
		whenCompleted: [ :ctrl | 
			OPRenameElementCommand executeOn: ctrl model.
			ctrl refreshFigure.
			self model isCormasModel
				ifTrue: [ ctrl addAutomaticCormasAssociation ] ].
	(aPalette newCreationEntry: [ OPUmlAttributeController new ])
		label: 'Attribute';
		icon: (self iconNamed: #abstractIcon);
		whenCompletedRename.
	(aPalette newCreationEntry: [ OPUmlOperationController new ])
		label: 'Method';
		icon: Smalltalk ui theme icons blankIcon;
		whenCompletedRename.
	(aPalette newConnectionCreationTool: [ OPUmlGeneralizationController new ])
		label: 'Inheritance';
		icon: OPUmlIcons generalizationIcon.
	(aPalette newConnectionCreationTool: [ OPUmlAssociationController new ])
		label: 'Association';
		icon: OPUmlIcons associationIcon
]
