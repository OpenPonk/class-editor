"
I am an edge shape representing a UML Generalization. I render a solid line with a hollow triangular arrowhead pointing to the general (super) classifier.
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

{ #category : 'Roassal2 - accessing' }
OPUmlGeneralizationShape >> headMarker [

	^ OPRSEmptyMarkerBuilder triangle
]
