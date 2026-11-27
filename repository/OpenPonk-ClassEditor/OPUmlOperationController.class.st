"
I am the controller for UML Operations. I manage UI form descriptions (like the `isAbstract` modifier) and handle the lifecycle of operation shapes within a class compartment.
"
Class {
	#name : 'OPUmlOperationController',
	#superclass : 'OPUmlClassifierItemController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPUmlOperationController class >> diagramElementClass [

	^ OPUmlOperationLabel
]

{ #category : 'accessing' }
OPUmlOperationController class >> viewModelClass [
	^ OPUmlOperationViewModel
]

{ #category : 'adding' }
OPUmlOperationController >> addDiagramElementToOwner [

	self intendedOwningDiagramElement addOperation: self diagramElement
]

{ #category : 'destruction' }
OPUmlOperationController >> removeDiagramElement [
	self diagramElement ifNotExists: [ ^ self ].
	self diagramElementOwnerWithPossibleController ifExists: [ :owner |
		owner removeOperation: self diagramElement ].
	self diagramElement: nil
]
