Class {
	#name : 'OPUmlAssociationControllerTest',
	#superclass : 'OPUmlRelationshipControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'accessing' }
OPUmlAssociationControllerTest >> controllerClass [
	^ OPUmlAssociationController
]

{ #category : 'construction' }
OPUmlAssociationControllerTest >> diagramElementClass [

	^ OPUmlAssociationShape
]

{ #category : 'accessing' }
OPUmlAssociationControllerTest >> modelClass [
	^ OPUMLAssociation
]

{ #category : 'tests - diagram' }
OPUmlAssociationControllerTest >> testNavigableRemovalOfAssociationRemovesMemberEnds [

	| first second attributeController attributeDiagramElement |
	self showInDiagram.
	first := model memberEnds first.
	second := model memberEnds second.
	self deny: (diagramController isVisibleInDiagram: second).
	controller writeNavigability: true to: second.
	diagramController showInDiagramModel: second.
	self assert: (diagramController isVisibleInDiagram: second).
	attributeController := diagramController controllerForModel: second.
	self
		assert: attributeController class
		equals: OPUmlAttributeController.
	attributeDiagramElement := attributeController diagramElement.
	self
		assert: attributeDiagramElement class
		equals: OPUmlAttributeLabel.
	self assert: attributeDiagramElement isRendered.
	self
		assertCollection: diagramController diagram allOwnedElements
		includesAny: { attributeDiagramElement }.
	controller removeControllerAndModel.
	self deny: (diagramController isVisibleInDiagram: controller).
	self deny: (diagramController isVisibleInDiagram: second).
	self
		denyCollection: diagramController diagram allOwnedElements
		includesAny: { attributeDiagramElement }
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
OPUmlAssociationControllerTest >> testWriteNavigabilityAssocOwnedToClassOwned [

	| first second |
	self prepareToShow.
	controller diagramController: diagramController.
	first := model memberEnds first.
	second := model memberEnds second.
	controller writeNavigability: true to: second.
	self assert: second isNavigable.
	self assert: second owningClass equals: first type
]

{ #category : 'tests' }
OPUmlAssociationControllerTest >> testWriteNavigabilityClassOwnedToAssocOwned [
	| first |
	self prepareToShow.
	controller diagramController: diagramController.
	first := model memberEnds first.
	controller writeNavigability: false to: first.
	self deny: first isNavigable.
	self assert: first owningClass equals: nil.
	self assert: first owningAssociation equals: model
]
