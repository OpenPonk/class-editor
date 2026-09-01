"
I am a unit test class verifying the behavior of OPUmlOperationController, ensuring correct diagram element creation and canvas removal.
"
Class {
	#name : 'OPUmlOperationControllerTest',
	#superclass : 'OPUmlClassifierItemControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'constants' }
OPUmlOperationControllerTest class >> diagramElementClass [

	^ OPUmlOperationLabel
]

{ #category : 'constants' }
OPUmlOperationControllerTest >> controllerClass [
	^ OPUmlOperationController
]

{ #category : 'constants' }
OPUmlOperationControllerTest >> modelClass [
	^ OPUMLOperation
]

{ #category : 'tests - creation' }
OPUmlOperationControllerTest >> testCreateDiagramElement [

	model owningClass: OPUMLClass new.
	diagramController showWithoutDependentInDiagramModel: model owningClass.

	super testCreateDiagramElement
]

{ #category : 'tests - removing' }
OPUmlOperationControllerTest >> testRemoveFromView [

	| class compartment op |
	class := OPUMLClass new.
	op := OPUMLOperation new.
	class ownedOperations add: op.
	diagramController showInDiagramModel: class.
	controller := diagramController controllerForModel: op.
	compartment := controller diagramElement owningElement.
	controller removeControllerAndDiagramElement.
	self assert: compartment ownedElements asArray equals: #(  )
]
