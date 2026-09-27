"
A classifier item label rendering a UML Operation inside an operation compartment, supporting italics for abstract operations.
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
