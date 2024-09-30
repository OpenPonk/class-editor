Class {
	#name : 'OPUmlClassifierItemController',
	#superclass : 'OPUmlElementController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'adding' }
OPUmlClassifierItemController >> addDiagramElementToOwner [

	self subclassResponsibility
]

{ #category : 'figures' }
OPUmlClassifierItemController >> createDiagramElement [

	diagramElement := self diagramElementClass forModelElement:
		                  self model.

	self addDiagramElementToOwner
]

{ #category : 'forms' }
OPUmlClassifierItemController >> descriptionName [

	<magritteDescription>
	| description |
	description := super descriptionName.
	description accessor writeBlock: [ :me :newValue |
		| text |
		text := newValue trim ifEmpty: [ self placeholderName ].
		me model name: text.
		self diagramElement modelChanged ].
	^ description
]

{ #category : 'announcements' }
OPUmlClassifierItemController >> internalSubscribeTo: aModel [

	aModel announcer
		when: OPElementRenamed
		do: [ self diagramElementOwner modelChanged ]
		for: self
]

{ #category : 'testing' }
OPUmlClassifierItemController >> isHideable [
	^ true
]

{ #category : 'hooks' }
OPUmlClassifierItemController >> placeholderName [

	^ self subclassResponsibility
]
