Class {
	#name : #OPUmlOperationControllerTest,
	#superclass : #OPUmlElementControllerTest,
	#category : #'OpenPonk-ClassEditor-Tests - Controllers'
}

{ #category : #accessing }
OPUmlOperationControllerTest >> controllerClass [
	^ OPUmlOperationController
]

{ #category : #accessing }
OPUmlOperationControllerTest >> modelClass [
	^ OPUMLOperation
]

{ #category : #tests }
OPUmlOperationControllerTest >> testCreateDiagramElement [
	self assert: controller createDiagramElement class equals: OPUmlLabel
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
	controller remove.
	self assert: compartment ownedElements asArray equals: #()
]

{ #category : #tests }
OPUmlOperationControllerTest >> testSupport [
	self assert: (diagramController hasSupportForModel: OPUMLOperation new)
]
