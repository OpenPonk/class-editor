Class {
	#name : #OPUmlClassItemLabel,
	#superclass : #OPUmlClassifierItemLabel,
	#traits : 'OPTDIColoredAsStroke',
	#classTraits : 'OPTDIColoredAsStroke classTrait',
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #accessing }
OPUmlClassItemLabel >> defaultText [

	^ self modelElement notationString
		  replaceAll: Character lf with: Character space;
		  replaceAll: Character cr with: Character space;
		  yourself
]

{ #category : #accessing }
OPUmlClassItemLabel >> emphasis [

	| emphasis |
	emphasis := super emphasis.
	self modelElement isStatic ifTrue: [ 
		emphasis add: TextEmphasis underlined ].
	^ emphasis
]
