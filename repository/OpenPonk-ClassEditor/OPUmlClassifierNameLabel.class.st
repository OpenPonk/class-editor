Class {
	#name : 'OPUmlClassifierNameLabel',
	#superclass : 'OPUmlNameLabel',
	#instVars : [
		'labeled'
	],
	#category : 'OpenPonk-ClassEditor-Shapes',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Shapes'
}

{ #category : 'as yet unclassified' }
OPUmlClassifierNameLabel >> defaultFontSize [

	^ 11
]

{ #category : 'accessing' }
OPUmlClassifierNameLabel >> defaultText [

	^ String streamContents: [ :stream |
		  self owningElement hiddenPackages do: [ :each |
			  stream << each name asString << '::' ].
		  stream
		  << ((self modelElement name ifNil: [ ' ' ]) ifEmpty: [ ' ' ]) ]
]

{ #category : 'as yet unclassified' }
OPUmlClassifierNameLabel >> emphasis [

	| emphasis |
	emphasis := super emphasis.
	self modelElement isAbstract ifTrue: [
		emphasis add: TextEmphasis italic ].
	^ emphasis
]

{ #category : 'as yet unclassified' }
OPUmlClassifierNameLabel >> isPositionableByUser [

	^ false
]

{ #category : 'removing' }
OPUmlClassifierNameLabel >> removeRender [

	self owningElement roassalShape ifNotNil: [ :owningRoassalShape |
		owningRoassalShape removeInteractionIfPresent: OPRSLabeled ].
	super removeRender.
	labeled := nil
]

{ #category : 'as yet unclassified' }
OPUmlClassifierNameLabel >> renderBasicShape [

	| targetShape |
	labeled := OPRSLabeled new.
	labeled shapeBuilder wrapStrategy:
		(RSWrapStrategy new wrapMaxWidth: 400).
	labeled shapeBuilder layout alignCenter.
	labeled locationDo: [ :location |
		location
			inner;
			middle;
			center ].
	targetShape := self owningElement roassalShape.
	targetShape @ labeled.
	^ labeled labelShape
]

{ #category : 'accessing' }
OPUmlClassifierNameLabel >> roassalShape [

	^ labeled
]

{ #category : 'actions' }
OPUmlClassifierNameLabel >> translateBy: aPosition [

	"ignore it - I can position myself automatically"

	
]

{ #category : 'actions' }
OPUmlClassifierNameLabel >> translateTo: aPosition [

	"ignore it - I can position myself automatically"

	
]

{ #category : 'rendering' }
OPUmlClassifierNameLabel >> updateRenderFromModel [

	super updateRenderFromModel.

	roassalShape := labeled labelShape.

	roassalShape shapes do: [ :each |
		self flag: 'https://github.com/pharo-graphics/Roassal/issues/64'.
		each metricsProvider: OPRSCairoMetricsProvider new ].
	roassalShape adjustToChildren.

	roassalShape signalUpdate
]
