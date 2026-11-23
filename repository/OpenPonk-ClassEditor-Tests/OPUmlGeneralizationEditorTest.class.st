"
Tests controller logic and UI editing workflows for UML generalization relationships.
"
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
	#category : 'OpenPonk-ClassEditor-Tests-UI',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'UI'
}

{ #category : 'running' }
OPUmlGeneralizationEditorTest >> setUp [
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
OPUmlGeneralizationEditorTest >> tearDown [
	diagramController ifNotNil: [ 
		diagramController controllers copy do: #removeControllerAndDiagramElement ].
	super tearDown
]

{ #category : 'tests' }
OPUmlGeneralizationEditorTest >> testBasicSaveRequiresUndoManagerAndExecutesThroughIt [

	| generalizationViewModel editor loggingUndoManager |
	generalizationViewModel := diagramController viewModelRegistry viewModelFor: generalization.
	editor := OPUmlGeneralizationEditor new.
	editor viewModel: generalizationViewModel.
	editor commentTextArea text: 'New Test Comment'.

	editor undoManager: nil.
	self
		should: [ editor basicSave ]
		raise: AssertionFailure
		description: 'basicSave must strictly reject execution without undoManager'.
	self should: [ editor save ] raise: AssertionFailure description: 'save without undoManager must reject execution via basicSave'.

	loggingUndoManager := OPUndoManager new.
	editor undoManager: loggingUndoManager.
	editor basicSave.
	self assert: loggingUndoManager canUndo description: 'Command must be recorded in undo history'.
	self assert: generalization ownedComments first body equals: 'New Test Comment'
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
OPUmlGeneralizationEditorTest >> testGeneralizationViewModelOpenEditorWithApplicationAndUndoManager [

	| generalizationViewModel application openedTitles changeCount |
	generalizationViewModel := diagramController viewModelRegistry viewModelFor: generalization.
	openedTitles := OrderedCollection new.
	changeCount := 0.
	generalizationViewModel announcer when: OPModelChanged do: [ changeCount := changeCount + 1 ] for: self.

	application := SpApplication new.
	(application stub registerWindow: Any) will: [ :aWindow |
			openedTitles add: aWindow title.
			aWindow whenOpenedDo: [ aWindow close ] ].

	[ generalizationViewModel openEditorWithApplication: application undoManager: diagramController undoManager ] ensure: [
		application closeAllWindows ].

	self assertCollection: openedTitles hasSameElements: { 'Edit Generalization' }.
	self assert: changeCount equals: 1
]

{ #category : 'tests' }
OPUmlGeneralizationEditorTest >> testModalWindowCloseSavesAndCancelDiscardsChanges [

	| generalizationViewModel cancelEditor saveEditor cancelApplication saveApplication |
	generalizationViewModel := diagramController viewModelRegistry viewModelFor: generalization.
	cancelApplication := SpApplication new.
	cancelEditor := OPUmlGeneralizationEditor new.
	cancelEditor application: cancelApplication.
	cancelEditor undoManager: diagramController undoManager.
	cancelEditor viewModel: generalizationViewModel.
	cancelEditor commentTextArea text: 'Modal Comment'.
	(cancelApplication stub registerWindow: Any) will: [ :aWindow |
		cancelEditor announcer when: SpWidgetDisplayed do: [ aWindow triggerCancelAction ] for: self ].

	[ cancelEditor openModal ] ensure: [ cancelApplication closeAllWindows ].
	self assertEmpty: generalization ownedComments.

	saveApplication := SpApplication new.
	saveEditor := OPUmlGeneralizationEditor new.
	saveEditor application: saveApplication.
	saveEditor undoManager: diagramController undoManager.
	saveEditor viewModel: generalizationViewModel.
	saveEditor commentTextArea text: 'Modal Comment'.
	(saveApplication stub registerWindow: Any) will: [ :aWindow |
		saveEditor announcer when: SpWidgetDisplayed do: [ aWindow triggerOkAction ] for: self ].

	[ saveEditor openModal ] ensure: [ saveApplication closeAllWindows ].
	self assert: generalization ownedComments first body equals: 'Modal Comment'
]

{ #category : 'tests' }
OPUmlGeneralizationEditorTest >> testSaveCommentIsUndoable [

	| activeUndoManager editor generalizationViewModel |
	activeUndoManager := OPUndoManager new.
	generalizationViewModel := diagramController viewModelRegistry viewModelFor: generalization.
	editor := OPUmlGeneralizationEditor new.
	editor undoManager: activeUndoManager.
	editor viewModel: generalizationViewModel.
	editor commentTextArea text: 'Initial Comment'.
	editor save.
	self assert: generalization ownedComments first body equals: 'Initial Comment'.
	editor commentTextArea text: 'Updated Comment'.
	editor save.
	self assert: generalization ownedComments first body equals: 'Updated Comment'.
	activeUndoManager undo.
	self assert: generalization ownedComments first body equals: 'Initial Comment'.
	activeUndoManager redo.
	self assert: generalization ownedComments first body equals: 'Updated Comment'
]

{ #category : 'tests' }
OPUmlGeneralizationEditorTest >> testSaveProducesLabeledTransactionWithoutUnchangedCommentCommand [

	| activeUndoManager generalizationViewModel editor recordedCommand |
	activeUndoManager := diagramController undoManager.
	generalizationViewModel := diagramController viewModelRegistry viewModelFor: generalization.

	editor := OPUmlGeneralizationEditor new.
	editor undoManager: activeUndoManager.
	editor viewModel: generalizationViewModel.

	editor generalizationSetsEditor addNewSet.
	editor save.

	self assert: activeUndoManager canUndo description: 'Saving generalization editor must record an undoable transaction'.
	recordedCommand := activeUndoManager undoStack last.
	self assert: recordedCommand description equals: 'Edit Generalization'.
	self assertCollection: (recordedCommand commands collect: #class) hasSameElements: { OPUmlUpdateGeneralizationSetsCommand }.
	self denyCollection: (recordedCommand commands collect: #class) includesAny: { OPUmlUpdateGeneralizationCommentCommand }
]

{ #category : 'tests' }
OPUmlGeneralizationEditorTest >> testViewModelHandlesNilCommentBodyAsEmptyString [

	| nilBodyComment generalizationViewModel editor |
	nilBodyComment := OPUMLComment new.
	nilBodyComment annotatedElements add: generalization.
	generalization ownedComments add: nilBodyComment.

	generalizationViewModel := diagramController viewModelRegistry viewModelFor: generalization.
	editor := OPUmlGeneralizationEditor new.
	editor undoManager: diagramController undoManager.
	editor viewModel: generalizationViewModel.

	self assert: editor commentTextArea text equals: ''.
	editor save.
	self deny: diagramController undoManager canUndo description: 'Saving unchanged nil-body comment must not record a command'
]

{ #category : 'tests' }
OPUmlGeneralizationEditorTest >> testViewModelPopulatesUnnamedClassifiersAndExistingComment [

	| unnamedGeneral unnamedSpecific unnamedGeneralization existingComment generalizationViewModel editor |
	unnamedGeneral := OPUMLClass new.
	unnamedSpecific := OPUMLClass new.
	package packagedElements
		add: unnamedGeneral;
		add: unnamedSpecific.
	unnamedGeneralization := OPUMLGeneralization new
		                         general: unnamedGeneral;
		                         specific: unnamedSpecific;
		                         yourself.
	unnamedSpecific generalizations add: unnamedGeneralization.
	existingComment := OPUMLComment new
		                   body: 'Existing note';
		                   yourself.
	existingComment annotatedElements add: unnamedGeneralization.
	unnamedGeneralization ownedComments add: existingComment.

	generalizationViewModel := diagramController viewModelRegistry viewModelFor: unnamedGeneralization.
	editor := OPUmlGeneralizationEditor new.
	editor undoManager: diagramController undoManager.
	editor viewModel: generalizationViewModel.

	self assert: editor commentTextArea text equals: 'Existing note'.
	editor commentTextArea text: ''.
	editor save.
	self assertEmpty: unnamedGeneralization ownedComments.

	diagramController undoManager undo.
	self assert: unnamedGeneralization ownedComments first identicalTo: existingComment.
	self assert: unnamedGeneralization ownedComments first body equals: 'Existing note'
]
