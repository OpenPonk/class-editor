"
I am the abstract base Roassal node for content that can be placed inside a structured UML compartment. I manage basic layout and spatial positioning relative to my owner.
"
Class {
	#name : 'OPUmlCompartmentableContent',
	#superclass : 'OPNode',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'accessing' }
OPUmlCompartmentableContent >> canHaveController [

	^ false
]

{ #category : 'rendering' }
OPUmlCompartmentableContent >> layoutOwnedElements [

	"do nothing"
]

{ #category : 'initialization' }
OPUmlCompartmentableContent >> modelChanged [

	self owningElement modelChanged
]

{ #category : 'as yet unclassified' }
OPUmlCompartmentableContent >> translateTopTo: aCoordinateY [

	self translateTo:
		self xCoordinateForOwner @ (aCoordinateY + (self height / 2)).
	self layoutOwnedElements
]

{ #category : 'geometry' }
OPUmlCompartmentableContent >> xCoordinateForOwner [

	^ self subclassResponsibility
]
