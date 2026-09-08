Class {
	#name : 'OPUmlGeneralizationSetsOfControllerEditorTest',
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
OPUmlGeneralizationSetsOfControllerEditorTest >> setUp [
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
OPUmlGeneralizationSetsOfControllerEditorTest >> tearDown [
	diagramController ifNotNil: [ 
		diagramController controllers copy do: #removeControllerAndDiagramElement ].
	super tearDown
]

{ #category : 'tests' }
OPUmlGeneralizationSetsOfControllerEditorTest >> testSetsEditorWorksPurelyWithViewModelWithoutDiagramController [
	"Verifies that OPUmlGeneralizationSetsOfControllerEditor initializes and saves using only OPUmlGeneralizationViewModel"
	| generalizationVM editor |
	generalizationVM := diagramController viewModelRegistry viewModelFor: generalization.

	editor := OPUmlGeneralizationSetsOfControllerEditor new.
	editor viewModel: generalizationVM.

	editor removeFromSet: generalizationSet.
	editor save.

	self deny: (generalizationSet generalizations includes: generalization)
]

{ #category : 'tests' }
OPUmlGeneralizationSetsOfControllerEditorTest >> testUncheckPartOfDoesNotFailWithDNU [
	"Verify that saving changes after unchecking Part of does not raise DNU #packagedElements"
	| editor |
	editor := OPUmlGeneralizationSetsOfControllerEditor new.
	editor generalizationController: generalizationController.

	editor removeFromSet: generalizationSet.
	editor save.

	self deny: (generalizationSet generalizations includes: generalization)
]
