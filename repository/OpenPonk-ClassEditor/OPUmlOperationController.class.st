"
I am the controller for UML Operations. I manage UI form descriptions (like the `isAbstract` modifier) and handle the lifecycle of operation shapes within a class compartment.
"
Class {
	#name : 'OPUmlOperationController',
	#superclass : 'OPUmlClassItemController',
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

{ #category : 'forms' }
OPUmlOperationController >> descriptionIsAbstract [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionIsAbstract' -> '`@receiver viewModel descriptionIsAbstract'.
	^ self viewModel descriptionIsAbstract
]

{ #category : 'destruction' }
OPUmlOperationController >> removeDiagramElement [

	self diagramElement ifNotExists: [ ^ self ].
	self diagramElementOwnerWithPossibleController ifNotNil: [ :owner |
		owner removeOperation: self diagramElement ].
	self diagramElement: nil
]
