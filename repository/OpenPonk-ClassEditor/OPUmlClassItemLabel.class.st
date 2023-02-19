Class {
	#name : #OPUmlClassItemLabel,
	#superclass : #OPUmlNameLabel,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #accessing }
OPUmlClassItemLabel >> defaultEmphasis [

	^ self modelElement isStatic
		  ifTrue: [ TextEmphasis underlined ]
		  ifFalse: [ TextEmphasis normal ]
]

{ #category : #accessing }
OPUmlClassItemLabel >> defaultText [

	^ self modelElement notationString
		  replaceAll: Character lf with: Character space;
		  replaceAll: Character cr with: Character space;
		  yourself
]

{ #category : #'as yet unclassified' }
OPUmlClassItemLabel >> translateTopTo: aCoordinateY [

	self translateTo:
		self xCoordinateForOwner @ (aCoordinateY + (self height / 2))
]

{ #category : #'as yet unclassified' }
OPUmlClassItemLabel >> xCoordinateForOwner [

	^ self owningElement encompassingRectangle left + (self width / 2)
]
