Class {
	#name : #OPRTUmlAdornments,
	#superclass : #RTInteraction,
	#instVars : [
		'adornments'
	],
	#category : 'OpenPonk-ClassEditor-Shapes'
}

{ #category : #accessing }
OPRTUmlAdornments >> adornments [
	^ adornments
]

{ #category : #accessing }
OPRTUmlAdornments >> adornments: aList [
	adornments := aList
]

{ #category : #adornments }
OPRTUmlAdornments >> createAdornmentFrom: anAssociation position: aPosition on: anElement [
	| box icon size |
	size := 20.
	box := RTBox new
		size: size;
		color: Color transparent;
		borderColor: Color black;
		element.
	(RTConstraint on: box background: anElement)
		top;
		right;
		outer;
		verticalPadding: (size * aPosition) negated;
		stick.
	icon := RTBitmap new
		form: anAssociation key;
		element.
	(RTConstraint on: icon background: box) stick.
	box addCallback: (TRAddedCallback block: [ box view add: icon ]).
	box addCallback: (TRRemoveCallback block: [ icon remove ]).
	box when: TRMouseLeftClick do: [ :evt | anAssociation value value ].
	^ box
]

{ #category : #adornments }
OPRTUmlAdornments >> hideAdornmentsOn: anElement [
	(anElement hasAttribute: self className)
		ifFalse: [ ^ self ].
	(anElement attributeAt: self className) do: #remove.
	anElement removeAttributeAt: self className.
	anElement view signalUpdate
]

{ #category : #initialization }
OPRTUmlAdornments >> initializeElement: anElement [
	anElement when: OPTRFocused do: [ :e | self showAdornmentsOn: anElement ].
	anElement when: OPTRUnfocused do: [ :e | self hideAdornmentsOn: anElement ]
]

{ #category : #adornments }
OPRTUmlAdornments >> showAdornmentsOn: anElement [
	| boxes |
	boxes := adornments
		withIndexCollect: [ :each :i | self createAdornmentFrom: each position: i on: anElement ].
	anElement attributeAt: self className put: boxes.
	anElement view addAll: boxes.
	anElement view signalUpdate
]
