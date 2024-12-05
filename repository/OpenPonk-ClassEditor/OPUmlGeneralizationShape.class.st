"
I represent a direct generalization line.
"
Class {
	#name : 'OPUmlGeneralizationShape',
	#superclass : 'OPUmlEdge',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'initialization' }
OPUmlGeneralizationShape >> createOwnedElementsWithoutController [

	self ownedElements ifNotEmpty: [ ^ self ].
	OPUmlGeneralizationLabel in: self
]

{ #category : 'hooks' }
OPUmlGeneralizationShape >> headMarker [

	^ OPRSEmptyMarkerBuilder triangle
]
