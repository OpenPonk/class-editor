"
I am an abstract controller for relationship-type elements.
"
Class {
	#name : #OPUmlRelationshipController,
	#superclass : #OPDirectionalRelationshipController,
	#traits : 'OPTUmlStereotypedElementController',
	#classTraits : 'OPTUmlStereotypedElementController classTrait',
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #testing }
OPUmlRelationshipController >> isHideable [
	^ true
]

{ #category : #accessing }
OPUmlRelationshipController >> magritteDescription [
	| container |
	container := MAPragmaBuilder for: self.
	container addAll: self stereotypeMagritteDescription.
	^ container
]
