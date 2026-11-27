"
I am the controller for UML Associations. I manage form descriptions for source and target ends, multiplicity, navigability, and provide functionality to explicitly swap the source and target direction.
"
Class {
	#name : 'OPUmlAssociationController',
	#superclass : 'OPUmlAbstractAssociationController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPUmlAssociationController class >> diagramElementClass [

	^ OPUmlAssociationShape
]

{ #category : 'accessing' }
OPUmlAssociationController class >> viewModelClass [
	^ OPUmlAssociationViewModel
]

{ #category : 'actions' }
OPUmlAssociationController >> endsSwapped [

	source := self diagramController controllerForModel: self viewModel modelSource.
	target := self diagramController controllerForModel: self viewModel modelTarget.
	self diagramElement ifExists: [ :shape | shape switchSourceAndTarget ]
]

{ #category : 'announcements' }
OPUmlAssociationController >> subscribeToViewModel [

	super subscribeToViewModel.
	self viewModel announcer weak
		when: OPAssociationEndsSwapped
		send: #endsSwapped
		to: self
]
