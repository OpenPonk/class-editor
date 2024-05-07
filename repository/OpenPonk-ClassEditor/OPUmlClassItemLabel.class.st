Class {
	#name : 'OPUmlClassItemLabel',
	#superclass : 'OPUmlClassifierItemLabel',
	#traits : 'OPTColoredAsFont',
	#classTraits : 'OPTColoredAsFont classTrait',
	#category : 'OpenPonk-ClassEditor-Shapes',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Shapes'
}

{ #category : 'accessing' }
OPUmlClassItemLabel >> defaultText [

	^ self modelElement notationString
		  replaceAll: Character lf with: Character space;
		  replaceAll: Character cr with: Character space;
		  yourself
]

{ #category : 'emphasis' }
OPUmlClassItemLabel >> emphasis [

	| emphasis |
	emphasis := super emphasis.
	self modelElement isStatic ifTrue: [
		emphasis add: TextEmphasis underlined ].
	^ emphasis
]
