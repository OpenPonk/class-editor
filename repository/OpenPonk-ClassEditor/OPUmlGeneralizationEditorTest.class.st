Class {
	#name : 'OPUmlGeneralizationEditorTest',
	#superclass : 'TestCase',
	#instVars : [
		'project',
		'package',
		'classGeneral',
		'classSpecific',
		'generalization',
		'generalizationSet',
		'generalizationController',
		'diagramController'
	],
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'running' }
OPUmlGeneralizationEditorTest >> setUp [
	| registry |
	super setUp.
	project := OPProject new.
	package := OPUMLPackage new name: 'TestPackage'.
	project addModel: package.

	classGeneral := OPUMLClass new name: 'House'.
	classSpecific := OPUMLClass new name: 'InsuredHouse'.
	package packagedElements add: classGeneral; add: classSpecific.

	generalization := OPUMLGeneralization new.
	generalization general: classGeneral; specific: classSpecific.
	classSpecific generalizations add: generalization.

	generalizationSet := OPUMLGeneralizationSet new name: 'insured gs'.
	generalizationSet generalizations add: generalization.
	package packagedElements add: generalizationSet.

	registry := OPViewModelRegistry forProject: project.

	diagramController := OPUmlPackageDiagramController new.
	diagramController viewModelRegistry: registry.
	diagramController model: package.
	diagramController diagramElement: (OPOpenPonkDiagram forModelElement: package).
	(OPCanvasPresenter new canvas: RSCanvas new; yourself) attachController: diagramController.

	diagramController showInDiagramModel: classGeneral.
	diagramController showInDiagramModel: classSpecific.
	diagramController showInDiagramModel: generalization.

	generalizationController := diagramController controllerForModel: generalization
]

{ #category : 'running' }
OPUmlGeneralizationEditorTest >> tearDown [
	diagramController ifNotNil: [ 
		diagramController controllers copy do: #removeControllerAndDiagramElement ].
	super tearDown
]

{ #category : 'tests' }
OPUmlGeneralizationEditorTest >> testGeneralizationEditorDelegatesToViewModelAndSavesComment [
	"Verifies that OPUmlGeneralizationEditor accepts a ViewModel, delegates to its subpresenters, and saves comments"
	| generalizationVM editor |
	generalizationVM := diagramController viewModelRegistry viewModelFor: generalization.

	editor := OPUmlGeneralizationEditor new.
	editor viewModel: generalizationVM.

	editor commentTextArea text: 'Updated test comment'.
	editor save.

	self assert: generalization ownedComments first body equals: 'Updated test comment'
]
