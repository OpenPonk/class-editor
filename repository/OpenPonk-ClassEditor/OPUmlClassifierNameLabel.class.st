"
I am a specialized label for rendering the main name of a UML Classifier. I handle specific emphasis rendering, such as italicizing the text when the represented classifier is abstract.
"
Class {
	#name : 'OPUmlClassifierNameLabel',
	#superclass : 'OPUmlNameLabel',
	#instVars : [
		'labeled'
	],
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'accessing' }
OPUmlClassifierNameLabel >> attachedShapes [

	labeled ifNil: [ ^ super attachedShapes ].

	^ super attachedShapes , { labeled labelShape }
]

{ #category : 'accessing' }
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

{ #category : 'emphasis' }
OPUmlClassifierNameLabel >> emphasis [

	| emphasis |
	emphasis := super emphasis.
	self modelElement isAbstract ifTrue: [
		emphasis add: TextEmphasis italic ].
	^ emphasis
]

{ #category : 'removing' }
OPUmlClassifierNameLabel >> removeRender [

	self owningElement roassalShape ifNotNil: [ :owningRoassalShape |
		owningRoassalShape removeInteractionIfPresent: OPRSLabeled ].
	super removeRender.
	labeled := nil
]

{ #category : 'rendering' }
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

{ #category : 'rendering' }
OPUmlClassifierNameLabel >> roassalShape [

	^ labeled
]

{ #category : 'interactions' }
OPUmlClassifierNameLabel >> shouldBePositionableByUser [

	^ false
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
