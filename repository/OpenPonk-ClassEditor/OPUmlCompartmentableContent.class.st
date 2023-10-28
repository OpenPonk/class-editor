Class {
	#name : #OPUmlCompartmentableContent,
	#superclass : #OPNode,
	#category : #'OpenPonk-ClassEditor-Shapes'
}

{ #category : #rendering }
OPUmlCompartmentableContent >> layoutOwnedElements [

	self roassalShape
		pushBack;
		signalUpdate
]

{ #category : #initialization }
OPUmlCompartmentableContent >> modelChanged [

	self owningElement modelChanged
]

{ #category : #'as yet unclassified' }
OPUmlCompartmentableContent >> translateTopTo: aCoordinateY [

	self translateTo:
		self xCoordinateForOwner @ (aCoordinateY + (self height / 2)).
	self layoutOwnedElements
]

{ #category : #'as yet unclassified' }
OPUmlCompartmentableContent >> xCoordinateForOwner [

	^ self subclassResponsibility
]
