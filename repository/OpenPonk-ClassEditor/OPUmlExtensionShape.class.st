"
I represent an Extension shape
"
Class {
	#name : #OPUmlExtensionShape,
	#superclass : #OPUmlAssociationShape,
	#instVars : [
		'isRequiredLabel'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #initialization }
OPUmlExtensionShape >> createEndLabels [

	OPUmlExtensionRequiredLabel
		in: self
		forModelElement: self modelElement
]

{ #category : #accessing }
OPUmlExtensionShape >> markerFor: aProperty [
	(aProperty name beginsWith: 'base_')
		ifTrue: [ ^ OPRSMarkerBuilder triangle ].
	^ nil
]
