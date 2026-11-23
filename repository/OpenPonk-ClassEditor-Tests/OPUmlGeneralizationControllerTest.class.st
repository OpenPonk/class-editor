"
I am a unit test class verifying the behavior of OPUmlGeneralizationController, focusing on source/target assignments and description configurations.
"
Class {
	#name : 'OPUmlGeneralizationControllerTest',
	#superclass : 'OPUmlRelationshipControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests-Controllers',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Controllers'
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
OPUmlGeneralizationControllerTest >> testCreateModelInWithClassifierAndNonClassifierParent [

	| firstController secondController thirdController |
	self prepareToShow.
	firstController := OPUmlGeneralizationController new
		                   diagramController: diagramController;
		                   source: self sourceController;
		                   target: self targetController;
		                   yourself.
	firstController createModelIn: sourceModel.
	self assert: firstController model specific identicalTo: sourceModel.
	self assert: firstController model general identicalTo: targetModel.

	secondController := OPUmlGeneralizationController new
		                    diagramController: diagramController;
		                    source: self sourceController;
		                    target: self targetController;
		                    yourself.
	secondController createModelIn: diagramController model.
	self assert: secondController model specific identicalTo: sourceModel.

	thirdController := OPUmlGeneralizationController new
		                   diagramController: diagramController;
		                   source: self sourceController;
		                   target: self targetController;
		                   yourself.
	thirdController createModelIn: Object new.
	self assert: thirdController model specific identicalTo: sourceModel
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

	self assertEmpty: generalizationSet generalizations.
	self assertEmpty: generalization1 generalizationSets.
	self assertEmpty: generalization2 generalizationSets.
	self denyCollection: package packagedElements includesAny: { generalizationSet }.
	self assert: activeUndoManager canUndo description: 'Deletion must be recorded in undo manager'.

	activeUndoManager undo.

	self assertCollection: package packagedElements includesAll: { generalizationSet }.
	self assertCollection: generalizationSet generalizations hasSameElements: {
			generalization1.
			generalization2 }.
	self assertCollection: generalization1 generalizationSets includesAll: { generalizationSet }.
	self assertCollection: generalization2 generalizationSets includesAll: { generalizationSet }.

	activeUndoManager redo.
	self assertEmpty: generalizationSet generalizations.
	self assertEmpty: generalization1 generalizationSets.
	self assertEmpty: generalization2 generalizationSets.
	self denyCollection: package packagedElements includesAny: { generalizationSet }
]

{ #category : 'tests' }
OPUmlGeneralizationControllerTest >> testDescriptionName [

	self prepareToShow.
	self assert: controller viewModel descriptionName identicalTo: nil
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

	self assertEmpty: generalizationSet generalizations.
	self assertEmpty: generalization1 generalizationSets.
	self assertEmpty: generalization2 generalizationSets.
	self denyCollection: package packagedElements includesAny: { generalizationSet }
]

{ #category : 'tests' }
OPUmlGeneralizationControllerTest >> testParentModelInTargetWithoutSource [

	| detachedController |
	self prepareToShow.
	controller source: nil.
	self assert: (controller parentModelInTarget: self targetController) identicalTo: sourceModel.

	detachedController := OPUmlGeneralizationController new.
	self assert: (detachedController parentModelInTarget: self targetController) identicalTo: nil
]

{ #category : 'tests' }
OPUmlGeneralizationControllerTest >> testRemovingGeneralClassifierRemovesGeneralizationAndController [
	"Verifies that removing the general classifier cascades to the generalization and its diagram controller"

	| generalizationDiagramElements |
	self showInDiagram.

	self assert: (diagramController hasControllerForModel: model) description: 'Generalization controller must exist before removal'.
	self denyCollection: targetModel generalizations includesAny: { model }.
	self assertCollection: sourceModel generalizations includesAll: { model }.
	generalizationDiagramElements := { controller diagramElement } , controller diagramElement ownedElements.

	"Delete the general classifier via its controller"
	self targetController removeControllerAndModel.

	"1. Generalization must be removed from the domain model"
	self denyCollection: sourceModel generalizations includesAny: { model }.

	"2. Generalization controller must be removed from the diagram"
	self deny: (diagramController hasControllerForModel: model) description: 'Generalization controller must be removed from diagram'.

	"3. Canvas must not contain any shapes or labels referencing the generalization"
	self denyCollection: (diagramController canvas shapes collect: #model) includesAny: generalizationDiagramElements.
	self assertEmpty:
		(diagramController canvas shapes select: [ :shape | shape model isNotNil and: [ shape model modelElement == model ] ])
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
	self assertCollection: package packagedElements includesAll: { genSet }.

	"Remove generalization via its ViewModel"
	controller viewModel removeModel.

	"GeneralizationSet was empty, so it must be removed from the package"
	self denyCollection: package packagedElements includesAny: { genSet }
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

	self assertCollection: package packagedElements includesAll: { generalizationSet }.
	self assertCollection: generalizationSet generalizations hasSameElements: {
			generalization1.
			generalization2 }.
	self assertCollection: generalization1 generalizationSets includesAll: { generalizationSet }.
	self assertCollection: generalization2 generalizationSets includesAll: { generalizationSet }
]
