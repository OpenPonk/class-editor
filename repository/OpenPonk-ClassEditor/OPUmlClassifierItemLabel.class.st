"
An abstract label for classifier compartment items (attributes, operations, literals), handling selection and relative positioning within its compartment.
"
Class {
	#name : 'OPUmlClassifierItemLabel',
	#superclass : 'OPUmlNameLabel',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'rendering' }
OPUmlClassifierItemLabel >> addedByMouseClickTo: aPoint [

	"do nothing"

	
]

{ #category : 'accessing' }
OPUmlClassifierItemLabel >> canHaveController [

	^ true
]

{ #category : 'initialization' }
OPUmlClassifierItemLabel >> modelChanged [

	self owningElement modelChanged
]

{ #category : 'interactions' }
OPUmlClassifierItemLabel >> selectableInteraction [

	^ OPRSSelectable highlightColorBlue
]

{ #category : 'interactions' }
OPUmlClassifierItemLabel >> shouldBePositionableByUser [

	^ false
]

{ #category : 'geometry' }
OPUmlClassifierItemLabel >> translateTopTo: aCoordinateY [
	self translateTo:
		self xCoordinateForOwner @ (aCoordinateY + (self height / 2))
]

{ #category : 'geometry' }
OPUmlClassifierItemLabel >> xCoordinateForOwner [

	^ self owningElement encompassingRectangle left + (self width / 2)
]
