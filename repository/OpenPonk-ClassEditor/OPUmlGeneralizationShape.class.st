"
I represent a direct generalization line.
"
Class {
	#name : #OPUmlGeneralizationShape,
	#superclass : #OPUmlEdge,
	#instVars : [
		'nameLabel',
		'constraints'
	],
	#category : #'OpenPonk-ClassEditor-Shapes'
}

{ #category : #initialization }
OPUmlGeneralizationShape >> createOwnedElementsWithoutController [

	self ownedElements ifNotEmpty: [ ^ self ].
	OPUmlGeneralizationLabel in: self
]

{ #category : #hooks }
OPUmlGeneralizationShape >> headMarker [

	^ OPRSEmptyMarkerBuilder triangle
]
