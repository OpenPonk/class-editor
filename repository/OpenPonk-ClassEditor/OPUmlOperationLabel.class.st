"
I am a specific class item label designed to render the text representation of a UML Operation inside a class operation compartment. I also handle specific emphasis, such as italicizing abstract operations.
"
Class {
	#name : 'OPUmlOperationLabel',
	#superclass : 'OPUmlClassItemLabel',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'emphasis' }
OPUmlOperationLabel >> emphasis [

	| emphasis |
	emphasis := super emphasis.
	self modelElement isAbstract ifTrue: [
		emphasis add: TextEmphasis italic ].
	^ emphasis
]
