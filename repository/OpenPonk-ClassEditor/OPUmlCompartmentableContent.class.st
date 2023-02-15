Class {
	#name : #OPUmlCompartmentableContent,
	#superclass : #OPNode,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #'as yet unclassified' }
OPUmlCompartmentableContent >> translateTopTo: aCoordinateY [

	self translateTo:
		self xCoordinateForOwner @ (aCoordinateY + (self height / 2))
]

{ #category : #'as yet unclassified' }
OPUmlCompartmentableContent >> xCoordinateForOwner [

	^ self subclassResponsibility
]
