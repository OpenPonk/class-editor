"
I am a base class for diagram element controllers.
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

{ #category : 'accessing' }
OPUmlElementController >> magritteDescription [
	| container |
	container := MAPragmaBuilder for: self.
	container addAll: self stereotypeMagritteDescription.
	^ container
]
