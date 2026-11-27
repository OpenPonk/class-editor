"
I am a unit test class verifying the behavior of OPUmlAssociationController, focusing on member end lifecycle, navigability state management, and removal cascading.
"
Class {
	#name : 'OPUmlAssociationControllerTest',
	#superclass : 'OPUmlRelationshipControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests-Controllers',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Controllers'
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
OPUmlAssociationControllerTest >> testEndsSwappedUpdatesSourceTargetAndShape [

	| originalSource originalTarget originalSourceShape originalTargetShape |
	self showInDiagram.
	originalSource := controller source.
	originalTarget := controller target.
	originalSourceShape := controller diagramElement source.
	originalTargetShape := controller diagramElement target.

	controller viewModel switchSourceAndTarget.

	self assert: controller source identicalTo: originalTarget.
	self assert: controller target identicalTo: originalSource.
	self assert: controller diagramElement source identicalTo: originalTargetShape.
	self assert: controller diagramElement target identicalTo: originalSourceShape.

	controller diagramElement: OPNoShape instance.
	controller viewModel switchSourceAndTarget.

	self assert: controller source identicalTo: originalSource.
	self assert: controller target identicalTo: originalTarget
]

{ #category : 'tests - diagram' }
OPUmlAssociationControllerTest >> testNavigableRemovalOfAssociationRemovesMemberEnds [

	| first second |
	self showInDiagram.
	first := model memberEnds first.
	second := model memberEnds second.

	controller viewModel writeNavigability: false to: second.
	self
		deny: (diagramController isVisibleInDiagram: second)
		description: 'Non-navigable member end must not be visible as attribute in diagram'.

	controller viewModel writeNavigability: true to: second.
	self
		deny: (diagramController isVisibleInDiagram: second)
		description: 'Navigable association end must not appear as attribute in diagram'.
	self assertCollection: first type ownedAttributes includesAll: { second }.

	controller viewModel writeNavigability: false to: second.
	self
		deny: (diagramController isVisibleInDiagram: second)
		description: 'Member end set to non-navigable must remain hidden from diagram'.
	self denyCollection: first type ownedAttributes includesAny: { second }.

	controller viewModel writeNavigability: true to: second.
	self
		deny: (diagramController isVisibleInDiagram: second)
		description: 'Member end set back to navigable must not spawn an attribute controller'.
	self assertCollection: first type ownedAttributes includesAll: { second }.

	controller removeControllerAndModel.
	self
		deny: (diagramController isVisibleInDiagram: model)
		description: 'Association model must no longer be visible in diagram after removal'.
	self denyCollection: first type ownedAttributes includesAny: { second }.
	self assert: second owningClass identicalTo: nil.
	self denyCollection: diagramController controllers includesAny: { controller }
]

{ #category : 'tests' }
OPUmlAssociationControllerTest >> testRedoDeletionOfNavigableAssociation [

	| class1 class2 assoc navProp prop2 |
	class1 := OPUMLClass new name: 'ClassA'.
	class2 := OPUMLClass new name: 'ClassB'.
	diagramController model packagedElements
		add: class1;
		add: class2.
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
	assoc memberEnds
		add: navProp;
		add: prop2.
	class1 ownedAttributes add: navProp.
	diagramController model packagedElements add: assoc.
	diagramController showInDiagramModel: assoc.

	diagramController undoManager inTransaction: [ diagramController removeModelElement: assoc ].

	diagramController undoManager undo.
	self assertCollection: diagramController model packagedElements includesAll: { assoc }.
	self assertCollection: assoc memberEnds hasSameElements: {
			navProp.
			prop2 }.

	diagramController undoManager redo.
	self denyCollection: diagramController model packagedElements includesAny: { assoc }.
	self assert: navProp owningClass identicalTo: nil.
	self deny: (diagramController hasControllerForModel: assoc) description: 'Association controller must be removed on redo'.

	diagramController undoManager undo.
	self assertCollection: diagramController model packagedElements includesAll: { assoc }.
	self assertCollection: assoc memberEnds hasSameElements: {
			navProp.
			prop2 }.
	self
		assert: (diagramController hasControllerForModel: assoc)
		description: 'Association controller must be restored on second undo'
]

{ #category : 'tests - diagram' }
OPUmlAssociationControllerTest >> testRemovalOfAssociationRemovesMemberEnds [

	self showInDiagram.
	(diagramController controllerForModel: model) removeControllerAndModel.
	(diagramController controllerForModel: sourceModel) removeControllerAndModel.
	(diagramController controllerForModel: targetModel) removeControllerAndModel.
	self assertEmpty: diagramController controllers
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
	self
		deny: (diagramController isVisibleInDiagram: model)
		description: 'Association must no longer be visible in diagram after command removal'.
	self denyCollection: (diagramController controllers collect: #model) includesAny: { model } , model memberEnds
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
	self denyCollection: (diagramController controllers collect: #model) includesAny: model memberEnds.
	self assertCollection: (diagramController controllers collect: #model) hasSameElements: {
			sourceModel.
			targetModel.
			model.
			model memberEnds first type.
			model memberEnds second type }.

	"Assert that the ViewModel tree is intact and still contains the association ends"
	self assertCollection: (diagramController viewModelRegistry viewModelFor: model) childrenModels hasSameElements: model memberEnds
]

{ #category : 'tests' }
OPUmlAssociationControllerTest >> testUndoDeletionOfNavigableAssociation [

	| class1 class2 assoc navProp prop2 |
	class1 := OPUMLClass new name: 'ClassA'.
	class2 := OPUMLClass new name: 'ClassB'.
	diagramController model packagedElements
		add: class1;
		add: class2.
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
	assoc memberEnds
		add: navProp;
		add: prop2.
	class1 ownedAttributes add: navProp.
	diagramController model packagedElements add: assoc.
	diagramController showInDiagramModel: assoc.

	diagramController undoManager inTransaction: [ diagramController removeModelElement: assoc ].
	self denyCollection: diagramController model packagedElements includesAny: { assoc }.
	self assert: navProp owningClass identicalTo: nil.

	diagramController undoManager undo.
	self assertCollection: diagramController model packagedElements includesAll: { assoc }.
	self assertCollection: assoc memberEnds hasSameElements: {
			navProp.
			prop2 }.
	self assert: navProp association identicalTo: assoc.
	self assert: (diagramController hasControllerForModel: assoc) description: 'Association controller must be restored on undo'
]

{ #category : 'tests' }
OPUmlAssociationControllerTest >> testWriteNavigabilityAssocOwnedToClassOwned [

	| first second |
	self prepareToShow.
	controller diagramController: diagramController.
	first := model memberEnds first.
	second := model memberEnds second.
	controller viewModel writeNavigability: true to: second.
	self assert: second isNavigable description: 'Second member end must become navigable'.
	self assert: second owningClass identicalTo: first type.
	self assertCollection: first type ownedAttributes includesAll: { second }
]

{ #category : 'tests' }
OPUmlAssociationControllerTest >> testWriteNavigabilityClassOwnedToAssocOwned [

	| first second |
	self prepareToShow.
	controller diagramController: diagramController.
	first := model memberEnds first.
	second := model memberEnds second.
	controller viewModel writeNavigability: true to: first.
	self assert: first isNavigable description: 'First member end must become navigable before reverting'.
	self assert: first owningClass identicalTo: second type.

	controller viewModel writeNavigability: false to: first.
	self deny: first isNavigable description: 'First member end must become non-navigable'.
	self assert: first owningClass identicalTo: nil.
	self assert: first owningAssociation identicalTo: model
]

{ #category : 'tests - diagram' }
OPUmlAssociationControllerTest >> testWriteNavigabilityUpdatesRenderedAssociationMarkersWithoutAttributeController [

	| first second |
	self showInDiagram.
	first := model memberEnds first.
	second := model memberEnds second.

	self assert: controller diagramElement roassalShape markerStart identicalTo: nil.
	self assert: controller diagramElement roassalShape markerEnd identicalTo: nil.

	controller viewModel writeNavigability: true to: second.
	self
		deny: (diagramController hasControllerForModel: second)
		description: 'Navigable target end must not create an attribute controller'.
	self assert: controller diagramElement roassalShape markerEnd shape class equals: OPRSBorderColoringComposite.
	self assert: controller diagramElement roassalShape markerStart identicalTo: nil.

	controller viewModel writeNavigability: true to: first.
	self
		deny: (diagramController hasControllerForModel: first)
		description: 'Navigable source end must not create an attribute controller'.
	self assert: controller diagramElement roassalShape markerStart shape class equals: OPRSBorderColoringComposite.
	self assert: controller diagramElement roassalShape markerEnd shape class equals: OPRSBorderColoringComposite.

	controller viewModel writeNavigability: false to: second.
	self assert: controller diagramElement roassalShape markerStart shape class equals: OPRSBorderColoringComposite.
	self assert: controller diagramElement roassalShape markerEnd identicalTo: nil
]
