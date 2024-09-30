Class {
	#name : 'OPUmlOperationLabel',
	#superclass : 'OPUmlClassItemLabel',
	#category : 'OpenPonk-ClassEditor-Shapes',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Shapes'
}

{ #category : 'emphasis' }
OPUmlOperationLabel >> emphasis [

	| emphasis |
	emphasis := super emphasis.
	self modelElement isAbstract ifTrue: [
		emphasis add: TextEmphasis italic ].
	^ emphasis
]
