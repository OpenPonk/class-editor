Class {
	#name : #OPUmlClassifierItemLabel,
	#superclass : #OPUmlNameLabel,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #'as yet unclassified' }
OPUmlClassifierItemLabel >> addedByMouseClickTo: aPoint [

	"do nothing"

	
]

{ #category : #'as yet unclassified' }
OPUmlClassifierItemLabel >> isPositionableByUser [

	^ false
]

{ #category : #initialization }
OPUmlClassifierItemLabel >> modelChanged [

	self owningElement modelChanged
]

{ #category : #rendering }
OPUmlClassifierItemLabel >> selectableInteraction [

	^ OPRSSelectable highlightColorBlue
]

{ #category : #'as yet unclassified' }
OPUmlClassifierItemLabel >> translateTopTo: aCoordinateY [

	self translateTo:
		self xCoordinateForOwner @ (aCoordinateY + (self height / 2))
]

{ #category : #'as yet unclassified' }
OPUmlClassifierItemLabel >> xCoordinateForOwner [

	^ self owningElement encompassingRectangle left + (self width / 2)
]
