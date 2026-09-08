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
OPUmlGeneralizationControllerTest >> testDescriptionName [

	self prepareToShow.
	self assert: controller viewModel descriptionName equals: nil
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
