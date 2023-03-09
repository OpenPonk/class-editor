Class {
	#name : #OPUmlClassifierNameLabel,
	#superclass : #OPUmlNameLabel,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #'as yet unclassified' }
OPUmlClassifierNameLabel >> createRoassalShape [

	self flag: #multiline.
	^ super createRoassalShape
]

{ #category : #'as yet unclassified' }
OPUmlClassifierNameLabel >> defaultFontSize [

	^ 11
]

{ #category : #accessing }
OPUmlClassifierNameLabel >> defaultText [

	^ (self modelElement name ifNil: [ ' ' ]) ifEmpty: [ ' ' ]
]

{ #category : #'as yet unclassified' }
OPUmlClassifierNameLabel >> emphasis [

	| emphasis |
	emphasis := super emphasis.
	self modelElement isAbstract ifTrue: [ 
		emphasis add: TextEmphasis italic ].
	^ emphasis
]

{ #category : #rendering }
OPUmlClassifierNameLabel >> updateRenderFromModel [

	roassalShape emphasis: self emphasis.

	super updateRenderFromModel
]
