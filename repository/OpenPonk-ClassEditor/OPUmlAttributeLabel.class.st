Class {
	#name : #OPUmlAttributeLabel,
	#superclass : #OPUmlNameLabel,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #accessing }
OPUmlAttributeLabel >> defaultEmphasis [

	^ self modelElement isStatic
		  ifTrue: [ TextEmphasis underlined ]
		  ifFalse: [ TextEmphasis normal ]
]

{ #category : #accessing }
OPUmlAttributeLabel >> defaultText [

	^ self modelElement notationString
		  replaceAll: Character lf with: Character space;
		  replaceAll: Character cr with: Character space;
		  yourself
]
