"
I am a unit test class verifying the behavior of OPUmlGeneralizationController, focusing on source/target assignments and description configurations.
"
Class {
	#name : 'OPUmlGeneralizationControllerTest',
	#superclass : 'OPUmlRelationshipControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'constants' }
OPUmlGeneralizationControllerTest class >> diagramElementClass [

	^ OPUmlGeneralizationShape
]

{ #category : 'initialization' }
OPUmlGeneralizationControllerTest >> assignModelSource [
	model specific: sourceModel
]

{ #category : 'initialization' }
OPUmlGeneralizationControllerTest >> assignModelTarget [
	model general: targetModel
]

{ #category : 'constants' }
OPUmlGeneralizationControllerTest >> controllerClass [
	^ OPUmlGeneralizationController
]

{ #category : 'constants' }
OPUmlGeneralizationControllerTest >> modelClass [
	^ OPUMLGeneralization
]

{ #category : 'tests' }
OPUmlGeneralizationControllerTest >> testDeleteGeneralizationSetWithMultipleGeneralizationsInEditorAndUndoRedo [
	| package generalizationSet generalization1 generalization2 editor activeUndoManager packageViewModel |
	package := OPUMLPackage new name: 'TestPackage'.
	generalizationSet := OPUMLGeneralizationSet new name: 'house gs'.
	generalization1 := OPUMLGeneralization new.
	generalization2 := OPUMLGeneralization new.
	package packagedElements add: generalizationSet.
	generalizationSet generalizations add: generalization1.
	generalizationSet generalizations add: generalization2.

	activeUndoManager := OPUndoManager new.
	packageViewModel := OPUmlPackageViewModel new.
	packageViewModel instVarNamed: 'model' put: package.

	editor := OPUmlAllGeneralizationSetsEditor new.
	editor undoManager: activeUndoManager.
	editor viewModel: packageViewModel.

	editor table items: (editor table items reject: [ :eachTableItem | eachTableItem uuid = generalizationSet uuid ]).
	editor save.

	self assert: generalizationSet generalizations isEmpty
		description: 'Deleted set must not retain any generalizations'.
	self assert: generalization1 generalizationSets isEmpty
		description: 'First generalization must be unlinked from set'.
	self assert: generalization2 generalizationSets isEmpty
		description: 'Second generalization must be unlinked from set'.
	self deny: (package packagedElements includes: generalizationSet)
		description: 'Package must not contain deleted set'.
	self assert: activeUndoManager canUndo
		description: 'Deletion must be recorded in undo manager'.

	activeUndoManager undo.

	self assert: (package packagedElements includes: generalizationSet)
		description: 'Set must be restored to package upon undo'.
	self assert: generalizationSet generalizations size equals: 2.
	self assert: (generalization1 generalizationSets includes: generalizationSet)
		description: 'First generalization must be restored upon undo'.
	self assert: (generalization2 generalizationSets includes: generalizationSet)
		description: 'Second generalization must be restored upon undo'.

	activeUndoManager redo.

	self assert: generalizationSet generalizations isEmpty.
	self assert: generalization1 generalizationSets isEmpty.
	self assert: generalization2 generalizationSets isEmpty.
	self deny: (package packagedElements includes: generalizationSet)
]

{ #category : 'tests' }
OPUmlGeneralizationControllerTest >> testDescriptionName [

	self prepareToShow.
	self assert: controller viewModel descriptionName equals: nil
]

{ #category : 'tests' }
OPUmlGeneralizationControllerTest >> testExecuteRemovesAllGeneralizationsFromDeletedSet [
	| package generalizationSet generalization1 generalization2 command |
	package := OPUMLPackage new name: 'TestPkg'.
	generalizationSet := OPUMLGeneralizationSet new name: 'TestSet'.
	generalization1 := OPUMLGeneralization new.
	generalization2 := OPUMLGeneralization new.
	package packagedElements add: generalizationSet.
	generalizationSet generalizations add: generalization1.
	generalizationSet generalizations add: generalization2.

	command := OPUmlUpdateGeneralizationSetsCommand new.
	command recordRemoveSet: generalizationSet fromPackage: package generalizations: generalizationSet generalizations asArray.
	command execute.

	self assert: generalizationSet generalizations isEmpty
		description: 'GeneralizationSet must have all generalizations removed upon deletion'.
	self assert: generalization1 generalizationSets isEmpty
		description: 'First generalization must not belong to removed set'.
	self assert: generalization2 generalizationSets isEmpty
		description: 'Second generalization must not belong to removed set'.
	self deny: (package packagedElements includes: generalizationSet)
		description: 'Package must not contain removed generalization set'
]

{ #category : 'tests' }
OPUmlGeneralizationControllerTest >> testRemovingGeneralClassifierRemovesGeneralizationAndController [
	"Verifies that removing the general classifier cascades to the generalization and its diagram controller"
	self showInDiagram.

	self assert: (diagramController hasControllerForModel: model).
	self assert: (targetModel generalizations includes: model) not.
	self assert: (sourceModel generalizations includes: model).

	"Delete the general classifier via its controller"
	self targetController removeControllerAndModel.

	"1. Generalization must be removed from the domain model"
	self deny: (sourceModel generalizations includes: model).

	"2. Generalization controller must be removed from the diagram"
	self deny: (diagramController hasControllerForModel: model).

	"3. Canvas must not contain any shapes or labels referencing the generalization"
	self deny: (diagramController canvas shapes anySatisfy: [ :shape |
		shape model = model or: [
		shape model isNotNil and: [ (shape model respondsTo: #generalization) and: [ shape model generalization = model ] ] ] ])
]

{ #category : 'tests' }
OPUmlGeneralizationControllerTest >> testRemovingGeneralizationCleansUpEmptyGeneralizationSet [
	"Verifies that basicRemoveModel removes an empty GeneralizationSet from its owning package"
	| genSet package |
	self prepareToShow.

	package := diagramController model.
	genSet := OPUMLGeneralizationSet new name: 'test gs'.
	genSet generalizations add: model.
	model generalizationSets add: genSet.
	package packagedElements add: genSet.

	self assert: (package packagedElements includes: genSet).

	"Remove generalization via its ViewModel"
	controller viewModel removeModel.

	"GeneralizationSet was empty, so it must be removed from the package"
	self deny: (package packagedElements includes: genSet)
]

{ #category : 'tests' }
OPUmlGeneralizationControllerTest >> testUndoRestoresGeneralizationsOfDeletedSet [
	| package generalizationSet generalization1 generalization2 command |
	package := OPUMLPackage new name: 'TestPkg'.
	generalizationSet := OPUMLGeneralizationSet new name: 'TestSet'.
	generalization1 := OPUMLGeneralization new.
	generalization2 := OPUMLGeneralization new.
	package packagedElements add: generalizationSet.
	generalizationSet generalizations add: generalization1.
	generalizationSet generalizations add: generalization2.

	command := OPUmlUpdateGeneralizationSetsCommand new.
	command recordRemoveSet: generalizationSet fromPackage: package generalizations: generalizationSet generalizations asArray.
	command execute.
	command undo.

	self assert: (package packagedElements includes: generalizationSet)
		description: 'Package must contain restored generalization set after undo'.
	self assert: generalizationSet generalizations size equals: 2.
	self assert: (generalization1 generalizationSets includes: generalizationSet)
		description: 'First generalization must be restored to generalization set'.
	self assert: (generalization2 generalizationSets includes: generalizationSet)
		description: 'Second generalization must be restored to generalization set'
]
