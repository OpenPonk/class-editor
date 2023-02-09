Class {
	#name : #OPUmlOperationLabel,
	#superclass : #OPUmlNameLabel,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #accessing }
OPUmlOperationLabel >> defaultEmphasis [

	| emphasis |
	emphasis := TextEmphasis normal.
	self modelElement isStatic ifTrue: [ 
		emphasis add: TextEmphasis underlined ].
	self modelElement isAbstract ifTrue: [ 
		emphasis add: TextEmphasis italic ].
	^ emphasis
]

{ #category : #accessing }
OPUmlOperationLabel >> defaultText [

	^ self modelElement notationString
		  replaceAll: Character lf with: Character space;
		  replaceAll: Character cr with: Character space;
		  yourself
]
