"
I am the controller for UML Classifiers (like Classes and Data Types). I manage packaging visibility, canvas hooks, validation, and stereotype adornments.
"
Class {
	#name : 'OPUmlClassifierController',
	#superclass : 'OPUmlElementController',
	#traits : 'OPTUmlPackageableController',
	#classTraits : 'OPTUmlPackageableController classTrait',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'connecting' }
OPUmlClassifierController >> canBeSourceFor: aController [
	^ aController isKindOf: OPUmlAssociationController
]

{ #category : 'figures' }
OPUmlClassifierController >> createAdornmentsBy: builder [

	"do nothing by default"
]

{ #category : 'construction' }
OPUmlClassifierController >> hookDiagramElement [

	super hookDiagramElement.

	self diagramElement adornmentCreationBlock: [ :builder |
		self createAdornmentsBy: builder ].
	self diagramElement hiddenPackages: self hiddenPackages
]

{ #category : 'updating' }
OPUmlClassifierController >> packageRenderChanged [

	self diagramElement ifNotNil: [ :foundDE |
		(foundDE hiddenPackages: self hiddenPackages) ifTrue: [
			foundDE isRendered ifTrue: [ foundDE updateRenderFromModel ] ] ]
]

{ #category : 'diagram elements' }
OPUmlClassifierController >> unhookDiagramElement [

	super unhookDiagramElement.

	(self diagramElement ifNotExists: [ ^ self ])
		adornmentCreationBlock: [ :builder |  ]
]

{ #category : 'event handling' }
OPUmlClassifierController >> updateAfterDiagramFocused [

	self diagramElement hiddenPackages: self hiddenPackages.
	super updateAfterDiagramFocused
]
