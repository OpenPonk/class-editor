Class {
	#name : #OPUmlClassifierItemLabel,
	#superclass : #OPUmlNameLabel,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #'as yet unclassified' }
OPUmlClassifierItemLabel >> addedByMouseClickTo: aPoint [

	"do nothing"

	
]

{ #category : #rendering }
OPUmlClassifierItemLabel >> renderShapeDetails [

	| selectable |
	super renderShapeDetails.
	selectable := OPRSSelectable new.
	selectable highlightColor: Color blue.
	roassalShape @ selectable
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
