Class {
	#name : #OPUmlClassifierNameLabel,
	#superclass : #OPUmlNameLabel,
	#instVars : [
		'labeled'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

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

{ #category : #testing }
OPUmlClassifierNameLabel >> isPositionableByUser [

	^ false
]

{ #category : #removing }
OPUmlClassifierNameLabel >> removeRender [

	(self owningElement roassalShape ifNil: [ ^ super removeRender ]) 
		removeInteractionIfPresent: OPRSLabeled.
	super removeRender
]

{ #category : #'as yet unclassified' }
OPUmlClassifierNameLabel >> renderBasicShape [

	| targetShape |
	labeled := OPRSLabeled new.
	labeled shapeBuilder wrapStrategy:
		(RSWrapStrategy new wrapMaxWidth: 400).
	labeled locationDo: [ :location | 
		location
			inner;
			middle;
			center ].
	targetShape := self owningElement roassalShape.
	targetShape @ labeled.
	^ labeled labelShape
]

{ #category : #accessing }
OPUmlClassifierNameLabel >> roassalShape [

	^ labeled
]

{ #category : #actions }
OPUmlClassifierNameLabel >> translateBy: aPosition [

	"ignore it - I can position myself automatically"

	
]

{ #category : #actions }
OPUmlClassifierNameLabel >> translateTo: aPosition [

	"ignore it - I can position myself automatically"

	
]

{ #category : #rendering }
OPUmlClassifierNameLabel >> updateRenderFromModel [

	super updateRenderFromModel.

	roassalShape := labeled labelShape
]
