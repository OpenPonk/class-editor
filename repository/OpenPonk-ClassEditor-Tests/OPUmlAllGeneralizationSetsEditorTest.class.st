"
Tests UI workflows, table interactions, modal window setup, and undoable saving for the all-generalization-sets editor.
"
Class {
	#name : 'OPUmlAllGeneralizationSetsEditorTest',
	#superclass : 'TestCase',
	#instVars : [
		'project',
		'package',
		'classGeneral',
		'classSpecific',
		'generalization',
		'generalizationSet',
		'projectController',
		'packageViewModel',
		'preexistingWindows'
	],
	#category : 'OpenPonk-ClassEditor-Tests-UI',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'UI'
}

{ #category : 'running' }
OPUmlAllGeneralizationSetsEditorTest >> setUp [

	super setUp.
	preexistingWindows := (self currentWorld submorphs select: [ :each | each isSystemWindow ]) asIdentitySet.
	project := OPProject named: 'AllGenSetsEditorTestProject'.
	package := OPUMLPackage new
		           name: 'TestPackage';
		           yourself.
	project addModel: package.

	classGeneral := OPUMLClass new
		                name: 'House';
		                yourself.
	classSpecific := OPUMLClass new
		                 name: 'InsuredHouse';
		                 yourself.
	package packagedElements
		add: classGeneral;
		add: classSpecific.

	generalization := OPUMLGeneralization new
		                  general: classGeneral;
		                  specific: classSpecific;
		                  yourself.
	classSpecific generalizations add: generalization.

	generalizationSet := OPUMLGeneralizationSet new
		                     name: 'insured gs';
		                     yourself.
	generalizationSet generalizations add: generalization.
	package packagedElements add: generalizationSet.

	projectController := OPProjectController forProject: project.
	packageViewModel := projectController viewModelRegistry viewModelFor: package
]

{ #category : 'running' }
OPUmlAllGeneralizationSetsEditorTest >> tearDown [

	| existing |
	existing := preexistingWindows ifNil: [ IdentitySet new ].
	self currentWorld submorphs copy do: [ :each |
		(each isSystemWindow and: [ (existing includes: each) not ]) ifTrue: [ each delete ] ].
	super tearDown
]

{ #category : 'tests' }
OPUmlAllGeneralizationSetsEditorTest >> testDeleteSetWithMultipleGeneralizationsPromptsAndRespectsConfirmation [

	| editor deleteColumn setCopy activeUndoManager |
	activeUndoManager := projectController undoManager.
	editor := OPUmlAllGeneralizationSetsEditor new.
	editor undoManager: activeUndoManager.
	editor viewModel: packageViewModel.
	deleteColumn := editor table columns fourth.
	setCopy := editor table items first.

	(editor stub confirm: Any) willReturn: false.
	deleteColumn action value: setCopy.
	self assert: editor table items size equals: 1.

	(editor stub confirm: Any) willReturn: true.
	deleteColumn action value: setCopy.
	self assertEmpty: editor table items.

	editor save.
	self denyCollection: package packagedElements includesAny: { generalizationSet }.
	self assertEmpty: generalizationSet generalizations.

	activeUndoManager undo.
	self assertCollection: package packagedElements includesAll: { generalizationSet }.
	self assertCollection: generalizationSet generalizations hasSameElements: { generalization }
]

{ #category : 'tests' }
OPUmlAllGeneralizationSetsEditorTest >> testInitializeWindowHandlesNilPackageName [

	| unnamedPackage unnamedPackageViewModel editor window |
	unnamedPackage := OPUMLPackage new.
	project addModel: unnamedPackage.
	unnamedPackageViewModel := projectController viewModelRegistry viewModelFor: unnamedPackage.

	editor := OPUmlAllGeneralizationSetsEditor new.
	editor undoManager: projectController undoManager.
	editor viewModel: unnamedPackageViewModel.
	window := editor asModalWindow.

	self assert: window title equals: 'Generalization Sets Editor ()'.
	self assert: window initialExtent equals: 500 @ 750.
	self assert: window closeOnBackdropClick description: 'All generalization sets modal must close on backdrop click'
]

{ #category : 'tests' }
OPUmlAllGeneralizationSetsEditorTest >> testModalWindowCloseSavesAndCancelDiscardsChanges [

	| cancelEditor saveEditor cancelApplication saveApplication |
	cancelApplication := SpApplication new.
	cancelEditor := OPUmlAllGeneralizationSetsEditor new.
	cancelEditor application: cancelApplication.
	cancelEditor undoManager: projectController undoManager.
	cancelEditor viewModel: packageViewModel.
	cancelEditor table columns first textChanged value: cancelEditor table items first value: 'Modal Name'.
	(cancelApplication stub registerWindow: Any) will: [ :aWindow |
		cancelEditor announcer when: SpWidgetDisplayed do: [ aWindow triggerCancelAction ] for: self ].

	[ cancelEditor openModal ] ensure: [ cancelApplication closeAllWindows ].
	self assert: generalizationSet name equals: 'insured gs'.

	saveApplication := SpApplication new.
	saveEditor := OPUmlAllGeneralizationSetsEditor new.
	saveEditor application: saveApplication.
	saveEditor undoManager: projectController undoManager.
	saveEditor viewModel: packageViewModel.
	saveEditor table columns first textChanged value: saveEditor table items first value: 'Modal Name'.
	(saveApplication stub registerWindow: Any) will: [ :aWindow |
		saveEditor announcer when: SpWidgetDisplayed do: [ aWindow triggerOkAction ] for: self ].

	[ saveEditor openModal ] ensure: [ saveApplication closeAllWindows ].
	self assert: generalizationSet name equals: 'Modal Name'
]

{ #category : 'tests' }
OPUmlAllGeneralizationSetsEditorTest >> testPackageForSetFallsBackToFindOwningPackageFor [

	| siblingPackage foreignSet editor resolvedPackage |
	siblingPackage := OPUMLPackage new
		                  name: 'SiblingPackage';
		                  yourself.
	foreignSet := OPUMLGeneralizationSet new
		              name: 'ForeignSet';
		              yourself.
	siblingPackage packagedElements add: foreignSet.
	project addModel: siblingPackage.

	editor := OPUmlAllGeneralizationSetsEditor new.
	editor viewModel: packageViewModel.

	resolvedPackage := editor packageForSet: foreignSet.
	self assert: resolvedPackage identicalTo: siblingPackage
]

{ #category : 'tests' }
OPUmlAllGeneralizationSetsEditorTest >> testPackageViewModelOpenEditorWithApplicationAndUndoManager [

	| application openedTitles changeCount |
	openedTitles := OrderedCollection new.
	changeCount := 0.
	packageViewModel announcer when: OPModelChanged do: [ changeCount := changeCount + 1 ] for: self.

	application := SpApplication new.
	(application stub registerWindow: Any) will: [ :aWindow |
			openedTitles add: aWindow title.
			aWindow whenOpenedDo: [ aWindow close ] ].

	[ packageViewModel openEditorWithApplication: application undoManager: projectController undoManager ] ensure: [
		application closeAllWindows ].

	self assertCollection: openedTitles hasSameElements: { 'Generalization Sets Editor (TestPackage)' }.
	self assert: changeCount equals: 1
]

{ #category : 'tests' }
OPUmlAllGeneralizationSetsEditorTest >> testSaveWithoutUndoManagerRejectsNonEmptyChangesAndAllowsNoOp [

	| editor nameColumn setCopy |
	editor := OPUmlAllGeneralizationSetsEditor new.
	editor viewModel: packageViewModel.

	editor save.
	self assert: generalizationSet name equals: 'insured gs'.

	nameColumn := editor table columns first.
	setCopy := editor table items first.
	nameColumn textChanged value: setCopy value: 'Unsaved Name'.

	self
		should: [ editor save ]
		raise: AssertionFailure
		description: 'Saving non-empty changes without undoManager must fail assertion'
]

{ #category : 'tests' }
OPUmlAllGeneralizationSetsEditorTest >> testTableColumnsEditNameCoveringDisjointAndUndoRedo [

	| editor columns nameColumn coveringColumn disjointColumn deleteColumn setCopy activeUndoManager |
	activeUndoManager := projectController undoManager.
	editor := OPUmlAllGeneralizationSetsEditor new.
	editor undoManager: activeUndoManager.
	editor viewModel: packageViewModel.

	columns := editor table columns.
	nameColumn := columns first.
	coveringColumn := columns second.
	disjointColumn := columns third.
	deleteColumn := columns fourth.
	setCopy := editor table items first.

	self deny: (coveringColumn evaluation value: setCopy) description: 'Covering must initially be false'.
	self deny: (disjointColumn evaluation value: setCopy) description: 'Disjoint must initially be false'.
	self assert: (deleteColumn evaluation value: setCopy) equals: 'Delete'.

	nameColumn textChanged value: setCopy value: 'Renamed Set'.
	coveringColumn onActivation value: setCopy.
	disjointColumn onActivation value: setCopy.
	self assert: (coveringColumn evaluation value: setCopy) description: 'Covering activation must set true'.
	self assert: (disjointColumn evaluation value: setCopy) description: 'Disjoint activation must set true'.
	disjointColumn onDeactivation value: setCopy.
	self deny: (disjointColumn evaluation value: setCopy) description: 'Disjoint deactivation must set false'.
	coveringColumn onDeactivation value: setCopy.
	coveringColumn onActivation value: setCopy.

	editor save.

	self assert: generalizationSet name equals: 'Renamed Set'.
	self assert: generalizationSet isCovering description: 'Covering change must be persisted'.
	self deny: generalizationSet isDisjoint description: 'Disjoint must remain false'.

	activeUndoManager undo.
	self assert: generalizationSet name equals: 'insured gs'.
	self deny: generalizationSet isCovering description: 'Undo must restore covering flag'.

	activeUndoManager redo.
	self assert: generalizationSet name equals: 'Renamed Set'.
	self assert: generalizationSet isCovering description: 'Redo must reapply covering flag'
]
