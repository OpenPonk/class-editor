"
I am the base controller for UML diagram elements. I provide common logic for property validation, stereotype management, and Magritte form generation.
"
Class {
	#name : 'OPUmlElementController',
	#superclass : 'OPElementController',
	#traits : 'OPTUmlStereotypedElementController',
	#classTraits : 'OPTUmlStereotypedElementController classTrait',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'connecting' }
OPUmlElementController >> parentWhenTargetFor: aCreatedController [
	^ aCreatedController isTargetUsedAsContainer
		  ifTrue: [ self model ]
		  ifFalse: [ aCreatedController source viewModel parentContainerModel ]
]
