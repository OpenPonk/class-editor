"
I am an abstract controller for relationship-type elements.
"
Class {
	#name : #OPUmlRelationshipController,
	#superclass : #OPUmlElementController,
	#traits : 'OPTRelationshipWithPathPointsController',
	#classTraits : 'OPTRelationshipWithPathPointsController classTrait',
	#instVars : [
		'source'
	],
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #testing }
OPUmlRelationshipController >> isHideable [
	^ true
]

{ #category : #accessing }
OPUmlRelationshipController >> source [
	^ source
]

{ #category : #accessing }
OPUmlRelationshipController >> source: anObject [
	source := anObject
]
