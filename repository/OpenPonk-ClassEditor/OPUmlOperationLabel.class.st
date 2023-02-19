Class {
	#name : #OPUmlOperationLabel,
	#superclass : #OPUmlClassItemLabel,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #accessing }
OPUmlOperationLabel >> defaultEmphasis [

	| emphasis |
	emphasis := super defaultEmphasis.
	self modelElement isAbstract ifTrue: [ 
		emphasis add: TextEmphasis italic ].
	^ emphasis
]
