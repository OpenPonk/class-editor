Class {
	#name : #OPUmlOperationLabel,
	#superclass : #OPUmlClassItemLabel,
	#category : #'OpenPonk-ClassEditor-Shapes'
}

{ #category : #accessing }
OPUmlOperationLabel >> emphasis [

	| emphasis |
	emphasis := super emphasis.
	self modelElement isAbstract ifTrue: [ 
		emphasis add: TextEmphasis italic ].
	^ emphasis
]
