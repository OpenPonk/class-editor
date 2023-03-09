Class {
	#name : #OPUmlOperationControllerTest,
	#superclass : #OPUmlElementControllerTest,
	#category : #'OpenPonk-ClassEditor-Tests - Controllers'
}

{ #category : #accessing }
OPUmlOperationControllerTest >> controllerClass [
	^ OPUmlOperationController
]

{ #category : #construction }
OPUmlOperationControllerTest >> diagramElementClass [

	^ OPUmlOperationLabel
]

{ #category : #accessing }
OPUmlOperationControllerTest >> modelClass [
	^ OPUMLOperation
]

{ #category : #tests }
OPUmlOperationControllerTest >> testCreateDiagramElement [

	model owningClass: OPUMLClass new.
	diagramController showWithoutDependentInDiagramModel: model owningClass.

	super testCreateDiagramElement
]

{ #category : #tests }
OPUmlOperationControllerTest >> testNotationText [
	self
		assert: (controller notationTextFor: (OPUMLOperation new name: 'attr'))
		equals: 'attr()'
]

{ #category : #'tests - removing' }
OPUmlOperationControllerTest >> testRemoveFromView [

	| class compartment op |
	class := OPUMLClass new.
	op := OPUMLOperation new.
	class ownedOperations add: op.
	diagramController showInDiagramModel: class.
	controller := diagramController controllerForModel: op.
	compartment := controller diagramElement owningElement.
	controller removeController.
	self assert: compartment ownedElements asArray equals: #(  )
]
