"
I am a unit test class verifying the behavior of OPUmlAssociationController, focusing on member end lifecycle, navigability state management, and removal cascading.
"
Class {
	#name : 'OPUmlAssociationControllerTest',
	#superclass : 'OPUmlRelationshipControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'constants' }
OPUmlAssociationControllerTest class >> diagramElementClass [

	^ OPUmlAssociationShape
]

{ #category : 'initialization' }
OPUmlAssociationControllerTest >> assignModelSource [
	model memberEnds first type: sourceModel.
	model memberEnds first owningClass: nil.
	model memberEnds first owningAssociation: model
]

{ #category : 'initialization' }
OPUmlAssociationControllerTest >> assignModelTarget [
	model memberEnds second type: targetModel.
	model memberEnds second owningClass: nil.
	model memberEnds second owningAssociation: model
]

{ #category : 'constants' }
OPUmlAssociationControllerTest >> controllerClass [
	^ OPUmlAssociationController
]

{ #category : 'constants' }
OPUmlAssociationControllerTest >> modelClass [
	^ OPUMLAssociation
]

{ #category : 'initialization' }
OPUmlAssociationControllerTest >> newModel [
	| assoc end1 end2 type1 type2 |
	assoc := super newModel.
	type1 := OPUMLClass new name: 'Type1'.
	type2 := OPUMLClass new name: 'Type2'.
	end1 := OPUMLProperty new name: 'sourceEnd'; type: type1; owningAssociation: assoc; association: assoc.
	end2 := OPUMLProperty new name: 'targetEnd'; type: type2; owningAssociation: assoc; association: assoc.
	assoc memberEnds add: end1; add: end2.
	^ assoc
]

{ #category : 'tests - diagram' }
OPUmlAssociationControllerTest >> testNavigableRemovalOfAssociationRemovesMemberEnds [
	| first second attributeController attributeDiagramElement |
	self showInDiagram.
	first := model memberEnds first.
	second := model memberEnds second.
	
	"Ensure initial state is non-navigable"
	controller viewModel writeNavigability: false to: second.
	self deny: (diagramController isVisibleInDiagram: second).
	
	"Toggle navigability back and forth and check if it is visible when it should"
	controller viewModel writeNavigability: true to: second.
	self assert: (diagramController isVisibleInDiagram: second).
	
	controller viewModel writeNavigability: false to: second.
	self deny: (diagramController isVisibleInDiagram: second).
	
	controller viewModel writeNavigability: true to: second.
	self assert: (diagramController isVisibleInDiagram: second).
	
	attributeController := diagramController controllerForModel: second.
	self assert: attributeController class equals: OPUmlAttributeController.
	
	attributeDiagramElement := attributeController diagramElement.
	self assert: attributeDiagramElement isRendered.
	self assertCollection: diagramController diagram allOwnedElements includesAny: { attributeDiagramElement }.
	
	"Cascaded removal via ViewModel safely cleans up endpoints"
	controller removeControllerAndModel.
	self deny: (diagramController isVisibleInDiagram: controller).
	self deny: (diagramController isVisibleInDiagram: second).
	self denyCollection: diagramController diagram allOwnedElements includesAny: { attributeDiagramElement }
]

{ #category : 'tests - diagram' }
OPUmlAssociationControllerTest >> testRemovalOfAssociationRemovesMemberEnds [

	self showInDiagram.
	(diagramController controllerForModel: model)
		removeControllerAndModel.
	(diagramController controllerForModel: sourceModel)
		removeControllerAndModel.
	(diagramController controllerForModel: targetModel)
		removeControllerAndModel.
	self
		assertCollection: diagramController controllers
		hasSameElements: #(  )
]

{ #category : 'tests' }
OPUmlAssociationControllerTest >> testShowAllElementsIgnoresNonNavigableEnds [
	"Verify that non-navigable association ends do not spawn diagram controllers, but remain logically in the ViewModel tree."

	diagramController model packagedElements
		add: sourceModel;
		add: targetModel;
		add: model.

	"Trigger diagram rendering which historically incorrectly spawned attribute controllers for association ends"
	diagramController showAllElements.

	"Assert that no controllers were created for the non-navigable association ends"
	self deny: (diagramController controllers anySatisfy: [ :ctrl |
		ctrl model = model memberEnds first or: [ ctrl model = model memberEnds second ] ])
		description: 'Controllers should not be created for non-navigable association ends'.

	"Assert that the ViewModel tree is intact and still contains the association ends"
	self assert: (diagramController viewModelRegistry viewModelFor: model) childrenModels size equals: 2.
]

{ #category : 'tests' }
OPUmlAssociationControllerTest >> testWriteNavigabilityAssocOwnedToClassOwned [

	| first second |
	self prepareToShow.
	controller diagramController: diagramController.
	first := model memberEnds first.
	second := model memberEnds second.
	controller viewModel writeNavigability: true to: second.
	self assert: second isNavigable.
	self assert: second owningClass equals: first type
]

{ #category : 'tests' }
OPUmlAssociationControllerTest >> testWriteNavigabilityClassOwnedToAssocOwned [

	| first |
	self prepareToShow.
	controller diagramController: diagramController.
	first := model memberEnds first.
	controller viewModel writeNavigability: false to: first.
	self deny: first isNavigable.
	self assert: first owningClass equals: nil.
	self assert: first owningAssociation equals: model
]
