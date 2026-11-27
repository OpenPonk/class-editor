"
I am the controller for UML Properties (Attributes). I manage UI form descriptions for type, multiplicity, uniqueness, and ordering, and handle diagram interactions when attributes are re-assigned or moved to associations.
"
Class {
	#name : 'OPUmlAttributeController',
	#superclass : 'OPUmlClassifierItemController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPUmlAttributeController class >> diagramElementClass [

	^ OPUmlAttributeLabel
]

{ #category : 'accessing' }
OPUmlAttributeController class >> viewModelClass [
	^ OPUmlClassPropertyViewModel
]

{ #category : 'adding' }
OPUmlAttributeController >> addDiagramElementToOwner [

	self intendedOwningDiagramElement addAttribute: self diagramElement
]

{ #category : 'announcements' }
OPUmlAttributeController >> associationChanged [

	super modelChanged
]

{ #category : 'construction' }
OPUmlAttributeController >> createDiagramElement [

	(self model name isNil or: [ self model name trim isEmpty ]) ifTrue: [
		self model name: self viewModel placeholderName ].
	^ super createDiagramElement
]

{ #category : 'announcements' }
OPUmlAttributeController >> modelChanged [

	super modelChanged.
	self model association ifNotNil: [ :association |
		self diagramController
			controllerForModel: association
			ifFound: [ :controller | controller classAttributeChanged ] ]
]

{ #category : 'destruction' }
OPUmlAttributeController >> removeDiagramElement [

	self diagramElement ifNotExists: [ ^ self ].
	self diagramElementOwnerWithPossibleController ifExists: [ :owner |
		owner removeAttribute: self diagramElement ].
	self diagramElement: nil
]
