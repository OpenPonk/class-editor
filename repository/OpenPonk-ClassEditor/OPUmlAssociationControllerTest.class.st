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

{ #category : 'tests - undo/redo' }
OPUmlAssociationControllerTest >> testRedoDeletionOfNavigableAssociation [
	| class1 class2 assoc navProp prop2 |
	diagramController undoManager ifNil: [
		diagramController undoManager: OPUndoManager new ].

	class1 := OPUMLClass new name: 'ClassA'.
	class2 := OPUMLClass new name: 'ClassB'.
	diagramController model packagedElements add: class1; add: class2.
	diagramController showInDiagramModel: class1.
	diagramController showInDiagramModel: class2.

	assoc := OPUMLAssociation new name: 'navAssoc'.
	navProp := OPUMLProperty new
		name: 'bEnd';
		type: class2;
		owningClass: class1;
		association: assoc.
	prop2 := OPUMLProperty new
		name: 'aEnd';
		type: class1;
		owningAssociation: assoc;
		association: assoc.
	assoc memberEnds add: navProp; add: prop2.
	class1 ownedAttributes add: navProp.
	diagramController model packagedElements add: assoc.
	diagramController showInDiagramModel: assoc.

	diagramController undoManager inTransaction: [
		diagramController removeModelElement: assoc ].

	diagramController undoManager undo.
	self assert: (diagramController model packagedElements includes: assoc).
	self assert: assoc memberEnds size equals: 2.

	diagramController undoManager redo.
	self deny: (diagramController model packagedElements includes: assoc).
	self assert: navProp owningClass isNil.
	self deny: (diagramController hasControllerForModel: assoc).

	diagramController undoManager undo.
	self assert: (diagramController model packagedElements includes: assoc).
	self assert: assoc memberEnds size equals: 2.
	self assert: (diagramController hasControllerForModel: assoc)
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
OPUmlAssociationControllerTest >> testRemoveAssociationViaCommandDoesNotFailOnDependentPropertyControllers [
	"Verify that deleting an association via OPRemoveModelOfRoassalShapeCommand does not attempt to create controllers for its non-navigable member ends"

	| assocShape command context |
	diagramController canvasPresenter attachController: diagramController.

	diagramController model packagedElements
		add: sourceModel;
		add: targetModel;
		add: model.

	diagramController showAllElements.
	assocShape := diagramController roassalShapeForModel: model.

	context := OPRoassalShapeContext for: diagramController canvasPresenter of: { assocShape }.
	command := OPRemoveModelOfRoassalShapeCommand new.
	command readParametersFromContext: context.

	command executeWithoutConfirmation.
	self deny: (diagramController isVisibleInDiagram: model)
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

{ #category : 'tests - undo/redo' }
OPUmlAssociationControllerTest >> testUndoDeletionOfNavigableAssociation [
	| class1 class2 assoc navProp prop2 |
	diagramController undoManager ifNil: [
		diagramController undoManager: OPUndoManager new ].

	class1 := OPUMLClass new name: 'ClassA'.
	class2 := OPUMLClass new name: 'ClassB'.
	diagramController model packagedElements add: class1; add: class2.
	diagramController showInDiagramModel: class1.
	diagramController showInDiagramModel: class2.

	assoc := OPUMLAssociation new name: 'navAssoc'.
	navProp := OPUMLProperty new
		name: 'bEnd';
		type: class2;
		owningClass: class1;
		association: assoc.
	prop2 := OPUMLProperty new
		name: 'aEnd';
		type: class1;
		owningAssociation: assoc;
		association: assoc.
	assoc memberEnds add: navProp; add: prop2.
	class1 ownedAttributes add: navProp.
	diagramController model packagedElements add: assoc.
	diagramController showInDiagramModel: assoc.

	diagramController undoManager inTransaction: [
		diagramController removeModelElement: assoc ].

	self deny: (diagramController model packagedElements includes: assoc).
	self assert: navProp owningClass isNil.

	diagramController undoManager undo.

	self assert: (diagramController model packagedElements includes: assoc).
	self assert: assoc memberEnds size equals: 2.
	self assert: navProp association equals: assoc.
	self assert: (diagramController hasControllerForModel: assoc)
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
