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
	#category : 'OpenPonk-ClassEditor-Tests - UI',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - UI'
}

{ #category : 'running' }
OPUmlGeneralizationSetsOfControllerEditorTest >> setUp [
	| projectController |
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

	projectController := OPProjectController forProject: project.

	diagramController := OPUmlPackageDiagramController new.
	projectController addDiagramController: diagramController.
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
OPUmlGeneralizationSetsOfControllerEditorTest >> testAddNewSetAndUndoRemovesLabelFromDiagram [
	| editor activeUndoManager labelElement labelShape |
	activeUndoManager := diagramController undoManager.
	editor := OPUmlGeneralizationSetsOfControllerEditor new.
	editor undoManager: activeUndoManager.
	editor viewModel: generalizationController viewModel.

	labelElement := generalizationController diagramElement ownedElements
		detect: [ :eachLabel | eachLabel isKindOf: OPUmlGeneralizationLabel ].
	labelShape := labelElement roassalShape.

	self assert: labelShape text equals: 'insured gs {}'.
	self assert: generalization generalizationSets size equals: 1.

	"1. Add a new generalization set for this generalization"
	editor addNewSet.
	editor save.

	self assert: generalization generalizationSets size equals: 2.
	self assert: labelShape text equals: 'insured gs {}; set {}'.

	"2. Perform Undo"
	activeUndoManager undo.

	self assert: generalization generalizationSets size equals: 1.
	self assert: labelShape text equals: 'insured gs {}'
]

{ #category : 'tests' }
OPUmlGeneralizationSetsOfControllerEditorTest >> testAddNewSetToStandaloneGeneralizationAndUndoClearsLabel [
	| classAnimal classCat standaloneGeneralization genController labelElement labelShape activeUndoManager editor |
	classAnimal := OPUMLClass new name: 'Animal'.
	classCat := OPUMLClass new name: 'Cat'.
	package packagedElements add: classAnimal; add: classCat.

	standaloneGeneralization := OPUMLGeneralization new.
	standaloneGeneralization general: classAnimal; specific: classCat.
	classCat generalizations add: standaloneGeneralization.

	diagramController showInDiagramModel: classAnimal.
	diagramController showInDiagramModel: classCat.
	diagramController showInDiagramModel: standaloneGeneralization.

	genController := diagramController controllerForModel: standaloneGeneralization.
	labelElement := genController diagramElement ownedElements
		detect: [ :eachLabel | eachLabel isKindOf: OPUmlGeneralizationLabel ].
	labelShape := labelElement roassalShape.

	self assert: labelShape text equals: ''.

	activeUndoManager := diagramController undoManager.
	editor := OPUmlGeneralizationSetsOfControllerEditor new.
	editor undoManager: activeUndoManager.
	editor viewModel: genController viewModel.

	editor addNewSet.
	editor save.

	self assert: standaloneGeneralization generalizationSets size equals: 1.
	self assert: labelShape text equals: 'set {}'.

	activeUndoManager undo.

	self assert: standaloneGeneralization generalizationSets size equals: 0.
	self assert: labelShape text equals: ''
]

{ #category : 'tests' }
OPUmlGeneralizationSetsOfControllerEditorTest >> testDeleteSetWorksPurelyWithViewModelWithoutController [
	"Verifies that deleting a generalization set works with viewModel only, when controller is nil."
	| generalizationVM editor |
	generalizationVM := diagramController viewModelRegistry viewModelFor: generalization.

	editor := OPUmlGeneralizationSetsOfControllerEditor new.
	editor viewModel: generalizationVM.

	editor deleteSet: generalizationSet.

	self deny: (editor table items anySatisfy: [ :each | each uuid = generalizationSet uuid ])
]

{ #category : 'tests' }
OPUmlGeneralizationSetsOfControllerEditorTest >> testSaveExecutesInsideUndoManagerTransaction [
	"Verifies that saving changes in generalization sets editor runs inside an undo transaction."
	| generalizationVM editor undoManager |
	undoManager := OPUndoManager new.
	generalizationVM := diagramController viewModelRegistry viewModelFor: generalization.

	editor := OPUmlGeneralizationSetsOfControllerEditor new.
	editor undoManager: undoManager.
	editor viewModel: generalizationVM.

	editor removeFromSet: generalizationSet.
	editor save.

	self assert: undoManager undoStack isNotEmpty.
	self deny: (generalizationSet generalizations includes: generalization).

	undoManager undo.
	self assert: (generalizationSet generalizations includes: generalization)
]

{ #category : 'tests' }
OPUmlGeneralizationSetsOfControllerEditorTest >> testSetsEditorWorksPurelyWithViewModelWithoutDiagramController [
	"Verifies that OPUmlGeneralizationSetsOfControllerEditor initializes and saves using only OPUmlGeneralizationViewModel"
	| generalizationViewModel editor |
	generalizationViewModel := diagramController viewModelRegistry viewModelFor: generalization.

	editor := OPUmlGeneralizationSetsOfControllerEditor new.
	editor undoManager: OPUndoManager new.
	editor viewModel: generalizationViewModel.

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
