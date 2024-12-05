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
