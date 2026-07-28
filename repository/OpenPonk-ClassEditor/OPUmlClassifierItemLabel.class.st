Class {
	#name : 'OPUmlClassifierItemLabel',
	#superclass : 'OPUmlNameLabel',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'as yet unclassified' }
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

{ #category : 'rendering' }
OPUmlClassifierItemLabel >> selectableInteraction [

	^ OPRSSelectable highlightColorBlue
]

{ #category : 'interactions' }
OPUmlClassifierItemLabel >> shouldBePositionableByUser [

	^ false
]

{ #category : 'as yet unclassified' }
OPUmlClassifierItemLabel >> translateTopTo: aCoordinateY [

	self translateTo:
		self xCoordinateForOwner @ (aCoordinateY + (self height / 2))
]

{ #category : 'as yet unclassified' }
OPUmlClassifierItemLabel >> xCoordinateForOwner [

	^ self owningElement encompassingRectangle left + (self width / 2)
]
