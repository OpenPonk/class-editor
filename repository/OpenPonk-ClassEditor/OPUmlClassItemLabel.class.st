Class {
	#name : #OPUmlClassItemLabel,
	#superclass : #OPUmlClassifierItemLabel,
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
