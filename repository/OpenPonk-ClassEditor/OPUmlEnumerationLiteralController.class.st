"
I am the controller for UML EnumerationLiterals. I ensure that new literal visuals are appropriately added to the parent Enumeration's compartment rather than the root canvas.
"
Class {
	#name : 'OPUmlEnumerationLiteralController',
	#superclass : 'OPUmlClassifierItemController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPUmlEnumerationLiteralController class >> diagramElementClass [

	^ OPUmlEnumerationLiteralLabel
]

{ #category : 'accessing' }
OPUmlEnumerationLiteralController class >> viewModelClass [
	^ OPUmlEnumerationLiteralViewModel
]

{ #category : 'adding' }
OPUmlEnumerationLiteralController >> addDiagramElementToOwner [

	self intendedOwningDiagramElement addLiteral: self diagramElement
]

{ #category : 'destruction' }
OPUmlEnumerationLiteralController >> removeDiagramElement [

	self diagramElement ifNotExists: [ ^ self ].
	self diagramElementOwnerWithPossibleController removeLiteral: self diagramElement.
	self diagramElement: nil
]
