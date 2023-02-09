Class {
	#name : #OPUmlExtensionEndLabels,
	#superclass : #OPUmlAssociationEndLabels,
	#category : #'OpenPonk-ClassEditor-Shapes'
}

{ #category : #'instance creation' }
OPUmlExtensionEndLabels class >> on: anAssociationShape [
	^ self basicNew
		initializeOn: anAssociationShape;
		yourself
]

{ #category : #adding }
OPUmlExtensionEndLabels >> addConstraintsTo: aCollection at: aPosition [

	"do nothing"

	
]

{ #category : #initialization }
OPUmlExtensionEndLabels >> initializeOn: anAssociationShape [

	self initialize.
	associationShape := anAssociationShape
]
