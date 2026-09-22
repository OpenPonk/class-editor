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
	diagramController undoManager: OPUndoManager new.
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
OPUmlGeneralizationEditorTest >> testBasicSaveRejectsMissingUndoManager [
	| specificClassifier generalClassifier generalization project projectController viewModelRegistry generalizationViewModel editor |
	specificClassifier := OPUMLClass new name: 'SpecificClass'.
	generalClassifier := OPUMLClass new name: 'GeneralClass'.
	generalization := OPUMLGeneralization new
		specific: specificClassifier;
		general: generalClassifier;
		yourself.
	specificClassifier generalizations add: generalization.

	project := OPProject named: 'GenEditorContractTestProject'.
	project addModel: specificClassifier.
	project addModel: generalClassifier.
	projectController := project controllerClass new
		project: project;
		yourself.
	viewModelRegistry := projectController viewModelRegistry.
	generalizationViewModel := viewModelRegistry viewModelFor: generalization.

	editor := OPUmlGeneralizationEditor new.
	editor viewModel: generalizationViewModel.
	editor commentTextArea text: 'Test Comment'.

	"Rule 4h: basicSave must strictly reject execution when undoManager is missing"
	editor undoManager: nil.
	self
		should: [ editor basicSave ]
		raise: AssertionFailure
		description: 'basicSave must strictly reject execution without undoManager'
]

{ #category : 'tests' }
OPUmlGeneralizationEditorTest >> testBasicSaveRequiresUndoManagerAndExecutesThroughIt [
	| package specificClassifier generalClassifier generalization project projectController viewModelRegistry generalizationViewModel editor loggingUndoManager |
	package := OPUMLPackage new name: 'PkgTest'.
	specificClassifier := OPUMLClass new name: 'SpecificClass'.
	generalClassifier := OPUMLClass new name: 'GeneralClass'.
	package packagedElements addAll: { specificClassifier . generalClassifier }.
	generalization := OPUMLGeneralization new
		specific: specificClassifier;
		general: generalClassifier;
		yourself.
	specificClassifier generalizations add: generalization.

	project := OPProject named: 'GenEditorTestProject'.
	project addModel: package.
	projectController := project controllerClass new project: project; yourself.
	viewModelRegistry := projectController viewModelRegistry.
	generalizationViewModel := viewModelRegistry viewModelFor: generalization.

	editor := OPUmlGeneralizationEditor new.
	editor viewModel: generalizationViewModel.
	editor commentTextArea text: 'New Test Comment'.

	"Contract 1: Execution without undoManager must fail assertion"
	editor undoManager: nil.
	self
		should: [ editor basicSave ]
		raise: AssertionFailure
		description: 'basicSave must strictly reject execution without undoManager (Rule 4h)'.

	"Contract 2: Execution with undoManager must be recorded in history"
	loggingUndoManager := OPUndoManager new.
	editor undoManager: loggingUndoManager.
	editor basicSave.
	self
		assert: loggingUndoManager canUndo
		description: 'Command must be recorded in undo history'
]

{ #category : 'tests' }
OPUmlGeneralizationEditorTest >> testGeneralizationEditorDelegatesToViewModelAndSavesComment [
	"Verifies that OPUmlGeneralizationEditor accepts a ViewModel, delegates to its subpresenters, and saves comments"
	| generalizationViewModel editor |
	generalizationViewModel := diagramController viewModelRegistry viewModelFor: generalization.

	editor := OPUmlGeneralizationEditor new.
	editor undoManager: diagramController undoManager.
	editor viewModel: generalizationViewModel.

	editor commentTextArea text: 'Updated test comment'.
	editor save.

	self assert: generalization ownedComments first body equals: 'Updated test comment'
]

{ #category : 'tests' }
OPUmlGeneralizationEditorTest >> testSaveCommentIsUndoable [
	| um editor generalizationVM |
	um := OPUndoManager new.
	generalizationVM := diagramController viewModelRegistry viewModelFor: generalization.
	editor := OPUmlGeneralizationEditor new.
	editor undoManager: um.
	editor viewModel: generalizationVM.
	editor commentTextArea text: 'Initial Comment'.
	editor save.
	self assert: generalization ownedComments first body equals: 'Initial Comment'.
	editor commentTextArea text: 'Updated Comment'.
	editor save.
	self assert: generalization ownedComments first body equals: 'Updated Comment'.
	um undo.
	self assert: generalization ownedComments first body equals: 'Initial Comment'.
	um redo.
	self assert: generalization ownedComments first body equals: 'Updated Comment'
]
