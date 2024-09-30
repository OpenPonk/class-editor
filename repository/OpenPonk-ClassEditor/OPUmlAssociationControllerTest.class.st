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
OPUmlAssociationControllerTest >> testRemovalOfAssociationRemovesMemberEnds [

	self showInDiagram.
	(diagramController controllerForModel: model)
		removeControllerAndModel.
	(diagramController controllerForModel: sourceModel)
		removeControllerAndModel.
	(diagramController controllerForModel: targetModel)
		removeControllerAndModel.
	self assert: diagramController controllers asArray equals: #(  )
]

{ #category : 'tests' }
OPUmlAssociationControllerTest >> testWriteNavigabilityAssocOwnedToClassOwned [
	| first second |
	self prepareToShow.
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
	first := model memberEnds first.
	controller writeNavigability: false to: first.
	self deny: first isNavigable.
	self assert: first owningClass equals: nil.
	self assert: first owningAssociation equals: model
]
