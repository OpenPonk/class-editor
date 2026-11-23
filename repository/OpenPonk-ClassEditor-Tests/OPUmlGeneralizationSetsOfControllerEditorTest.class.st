"
Tests UI editing and assignment of UML generalization sets across class generalization hierarchies.
"
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
	#category : 'OpenPonk-ClassEditor-Tests-UI',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'UI'
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
OPUmlGeneralizationSetsOfControllerEditorTest >> testAddGeneralizationSetButtonAndPartOfColumnCallbacks [

	| otherSpecific otherGeneralization otherSet editor partOfColumn otherSetCopy activeUndoManager addButton |
	otherSpecific := OPUMLClass new
		                 name: 'OtherHouse';
		                 yourself.
	package packagedElements add: otherSpecific.
	otherGeneralization := OPUMLGeneralization new
		                       general: classGeneral;
		                       specific: otherSpecific;
		                       yourself.
	otherSpecific generalizations add: otherGeneralization.
	otherSet := OPUMLGeneralizationSet new
		            name: 'other gs';
		            yourself.
	otherSet generalizations add: otherGeneralization.
	package packagedElements add: otherSet.

	activeUndoManager := diagramController undoManager.
	editor := OPUmlGeneralizationSetsOfControllerEditor new.
	editor undoManager: activeUndoManager.
	editor viewModel: generalizationController viewModel.

	self assert: editor defaultLayout class identicalTo: SpBoxLayout.

	partOfColumn := editor table columns first.
	otherSetCopy := editor table items detect: [ :each | each uuid = otherSet uuid ].
	self deny: (partOfColumn evaluation value: otherSetCopy) description: 'Generalization must not initially be part of otherSet'.

	partOfColumn onActivation value: otherSetCopy.
	self assert: (partOfColumn evaluation value: otherSetCopy) description: 'Activating Part of must include generalization'.

	partOfColumn onDeactivation value: otherSetCopy.
	self deny: (partOfColumn evaluation value: otherSetCopy) description: 'Deactivating Part of must exclude generalization'.

	partOfColumn onActivation value: otherSetCopy.
	addButton := editor instVarNamed: #addGeneralizationSetButton.
	addButton click.
	editor save.

	self assertCollection: otherSet generalizations includesAll: {
			otherGeneralization.
			generalization }.
	self assert: generalization generalizationSets size equals: 3.

	activeUndoManager undo.
	self denyCollection: otherSet generalizations includesAny: { generalization }.
	self assert: generalization generalizationSets size equals: 1
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
	package packagedElements
		add: classAnimal;
		add: classCat.

	standaloneGeneralization := OPUMLGeneralization new.
	standaloneGeneralization
		general: classAnimal;
		specific: classCat.
	classCat generalizations add: standaloneGeneralization.

	diagramController showInDiagramModel: classAnimal.
	diagramController showInDiagramModel: classCat.
	diagramController showInDiagramModel: standaloneGeneralization.

	genController := diagramController controllerForModel: standaloneGeneralization.
	labelElement := genController diagramElement ownedElements detect: [ :eachLabel | eachLabel isKindOf: OPUmlGeneralizationLabel ].
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

	self assertEmpty: standaloneGeneralization generalizationSets.
	self assert: labelShape text equals: ''
]

{ #category : 'tests' }
OPUmlGeneralizationSetsOfControllerEditorTest >> testCancelledDeleteSetPreservesMembership [

	| otherSpecific otherGeneralization editor setCopy |
	otherSpecific := OPUMLClass new
		                 name: 'OtherHouse';
		                 yourself.
	package packagedElements add: otherSpecific.
	otherGeneralization := OPUMLGeneralization new
		                       general: classGeneral;
		                       specific: otherSpecific;
		                       yourself.
	otherSpecific generalizations add: otherGeneralization.
	generalizationSet generalizations add: otherGeneralization.

	editor := OPUmlGeneralizationSetsOfControllerEditor new.
	editor undoManager: diagramController undoManager.
	editor viewModel: generalizationController viewModel.
	(editor stub confirm: Any) willReturn: false.

	setCopy := editor table items first.
	editor deleteSet: setCopy.
	editor save.

	self assertCollection: (editor table items collect: #uuid) includesAll: { generalizationSet uuid }.
	self assertCollection: generalizationSet generalizations includesAll: {
			generalization.
			otherGeneralization }
]

{ #category : 'tests' }
OPUmlGeneralizationSetsOfControllerEditorTest >> testDeleteSetWorksPurelyWithViewModelWithoutController [

	| generalizationViewModel editor |
	generalizationViewModel := diagramController viewModelRegistry viewModelFor: generalization.

	editor := OPUmlGeneralizationSetsOfControllerEditor new.
	editor viewModel: generalizationViewModel.

	editor deleteSet: generalizationSet.

	self denyCollection: (editor table items collect: #uuid) includesAny: { generalizationSet uuid }
]

{ #category : 'tests' }
OPUmlGeneralizationSetsOfControllerEditorTest >> testSaveExecutesInsideUndoManagerTransaction [

	| generalizationViewModel editor activeUndoManager |
	activeUndoManager := OPUndoManager new.
	generalizationViewModel := diagramController viewModelRegistry viewModelFor: generalization.

	editor := OPUmlGeneralizationSetsOfControllerEditor new.
	editor undoManager: activeUndoManager.
	editor viewModel: generalizationViewModel.

	editor removeFromSet: generalizationSet.
	editor save.
	self denyEmpty: activeUndoManager undoStack.
	self denyCollection: generalizationSet generalizations includesAny: { generalization }.

	activeUndoManager undo.
	self assertCollection: generalizationSet generalizations includesAll: { generalization }
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
	self denyCollection: generalizationSet generalizations includesAny: { generalization }
]

{ #category : 'tests' }
OPUmlGeneralizationSetsOfControllerEditorTest >> testUncheckPartOfDoesNotFailWithDNU [

	| editor |
	editor := OPUmlGeneralizationSetsOfControllerEditor new.
	editor undoManager: diagramController undoManager.
	editor viewModel: generalizationController viewModel.

	editor removeFromSet: generalizationSet.
	editor save.
	self denyCollection: generalizationSet generalizations includesAny: { generalization }
]

{ #category : 'tests' }
OPUmlGeneralizationSetsOfControllerEditorTest >> testUncheckedNewSetIsNotAddedToPackage [

	| editor addedSet initialElementCount |
	initialElementCount := package packagedElements size.
	editor := OPUmlGeneralizationSetsOfControllerEditor new.
	editor undoManager: diagramController undoManager.
	editor viewModel: generalizationController viewModel.

	editor addNewSet.
	addedSet := editor table items first.
	editor removeFromSet: addedSet.
	editor save.

	self assert: package packagedElements size equals: initialElementCount.
	self denyCollection: package packagedElements includesAny: { addedSet }
]
