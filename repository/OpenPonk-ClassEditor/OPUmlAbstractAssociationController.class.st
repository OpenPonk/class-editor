"
I am the base controller for UML Associations (both directed and bidirectional). I subscribe to property navigability changes and update the relationship arrow markers accordingly.
"
Class {
	#name : 'OPUmlAbstractAssociationController',
	#superclass : 'OPUmlRelationshipController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'announcements' }
OPUmlAbstractAssociationController >> classAttributeChanged [

	super modelChanged
]

{ #category : 'announcements' }
OPUmlAbstractAssociationController >> modelChanged [
	super modelChanged.
	self model memberEnds
		select: [ :each | each owningClass isNotNil ]
		thenDo: [ :each |
			self diagramController
				controllerForModel: each
				ifFound: [ :controller | controller associationChanged ] ]
]

{ #category : 'announcements' }
OPUmlAbstractAssociationController >> navigabilityChanged: anAnnouncement [
	| prop |
	prop := anAnnouncement property.
	prop owningClass
		ifNotNil: [ 
			self diagramController showInDiagramModel: prop.
			self diagramController controllerForModel: prop ifFound: [ :c | c associationChanged ] ]
		ifNil: [ 
			self diagramController controllerForModel: prop ifFound: [ :c | c removeControllerAndDiagramElement ] ]
]

{ #category : 'announcements' }
OPUmlAbstractAssociationController >> subscribeToViewModel [
	super subscribeToViewModel.
	self viewModel announcer weak
		when: OPUmlNavigabilityChanged
		send: #navigabilityChanged:
		to: self
]

{ #category : 'validation' }
OPUmlAbstractAssociationController >> validateMemberEndCount [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver validateMemberEndCount' -> '`@receiver viewModel validateMemberEndCount'.
	^ self viewModel validateMemberEndCount
]
