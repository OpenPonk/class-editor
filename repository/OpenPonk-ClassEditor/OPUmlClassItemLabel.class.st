"
I am the base label for items explicitly within a UML Class (like attributes and operations). I inherit color and font styling traits to respect diagram-level style configurations.
"
Class {
	#name : 'OPUmlClassItemLabel',
	#superclass : 'OPUmlClassifierItemLabel',
	#traits : 'OPTColoredAsFont',
	#classTraits : 'OPTColoredAsFont classTrait',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
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
