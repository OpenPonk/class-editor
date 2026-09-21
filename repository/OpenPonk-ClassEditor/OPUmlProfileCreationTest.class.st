Class {
	#name : 'OPUmlProfileCreationTest',
	#superclass : 'TestCase',
	#instVars : [
		'project',
		'diagram',
		'diagramController',
		'palette'
	],
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'as yet unclassified' }
OPUmlProfileCreationTest >> setUp [
	| registry package |
	super setUp.
	project := OPProject new.
	package := OPUMLPackage new name: 'TestPackage'.
	project addModel: package.
	diagram := OPOpenPonkDiagram forModelElement: package.
	project addDiagram: diagram.
	registry := OPViewModelRegistry forProject: project.
	diagramController := OPUmlPackageDiagramController new.
	diagramController
		workbenchAnnouncer: Announcer new;
		viewModelRegistry: registry;
		model: package;
		diagramElement: diagram.
	palette := OPPalette new.
	diagramController initializePalette: palette
]

{ #category : 'as yet unclassified' }
OPUmlProfileCreationTest >> tearDown [
	palette := nil.
	diagramController := nil.
	diagram := nil.
	project := nil.
	super tearDown
]

{ #category : 'tests' }
OPUmlProfileCreationTest >> testControllerFactoryCreatesProfileControllerForProfileModel [
	| profileModel createdController |
	profileModel := OPUMLProfile new.
	createdController := diagramController controllerFactory newControllerFor: profileModel.

	self assert: (createdController isKindOf: OPUmlProfileController)
]

{ #category : 'tests' }
OPUmlProfileCreationTest >> testProfilePaletteEntryCreatesProfileModelAndViewModel [
	| profileEntry tool createdController |
	profileEntry := palette entries detect: [ :eachEntry | eachEntry label = 'Profile' ].
	profileEntry select.
	tool := profileEntry tool.
	createdController := tool instVarNamed: #objectController.
	createdController diagramController: diagramController.
	createdController createModelIn: diagramController model.

	self assert: (createdController model isKindOf: OPUMLProfile).
	self assert: (createdController viewModel isKindOf: OPUmlProfileViewModel).
	self assert: (createdController isKindOf: OPUmlProfileController)
]
