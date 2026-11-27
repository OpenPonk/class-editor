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
OPUmlAbstractAssociationController >> navigabilityChanged: anAnnouncement [

	self modelChanged
]

{ #category : 'announcements' }
OPUmlAbstractAssociationController >> subscribeToViewModel [
	super subscribeToViewModel.
	self viewModel announcer weak
		when: OPUmlNavigabilityChanged
		send: #navigabilityChanged:
		to: self
]
