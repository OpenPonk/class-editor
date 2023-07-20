Class {
	#name : #OPUmlCompartmentableContent,
	#superclass : #OPNode,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #rendering }
OPUmlCompartmentableContent >> layoutOwnedElements [

	"do nothing by default"
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