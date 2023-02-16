Class {
	#name : #OPUmlCompartmentableShape,
	#superclass : #OPShape,
	#traits : 'OPTUmlAutoAccomodatingShape',
	#classTraits : 'OPTUmlAutoAccomodatingShape classTrait',
	#instVars : [
		'separators'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #accessing }
OPUmlCompartmentableShape >> addSeparator [

	| newSeparator |
	newSeparator := RSPolyline new.
	newSeparator color: Color black.
	self roassalShape canvas add: newSeparator.
	separators add: newSeparator
]

{ #category : #rendering }
OPUmlCompartmentableShape >> bottomPadding [

	^ 2
]

{ #category : #accessing }
OPUmlCompartmentableShape >> compartments [

	^ self ownedElements select: [ :each | each isKindOf: OPUmlCompartment ]
]

{ #category : #rendering }
OPUmlCompartmentableShape >> layout [

	self accomodateContents
]

{ #category : #rendering }
OPUmlCompartmentableShape >> layoutContents [

	self layoutOwnedElements.
	self layoutSeparators
]

{ #category : #rendering }
OPUmlCompartmentableShape >> layoutOwnedElements [

	^ self ownedElements
		  inject:
		  self roassalShape encompassingRectangle top + self topPadding
		  into: [ :prevHeight :each | 
			  each translateTopTo: prevHeight.
			  prevHeight + each height + 1 ]
]

{ #category : #rendering }
OPUmlCompartmentableShape >> layoutSeparators [

	| yCoordinates left right |
	yCoordinates := (self compartments ifEmpty: [ ^ self ]) collect: [ 
		                :each | each top ].

	left := self roassalShape encompassingRectangle left.
	right := self roassalShape encompassingRectangle right.

	self separators withIndexDo: [ :each :index | 
		| y |
		y := yCoordinates at: index.
		each controlPoints: { 
				(left @ y).
				(right @ y) } ]
]

{ #category : #rendering }
OPUmlCompartmentableShape >> leftPadding [

	^ 2
]

{ #category : #accessing }
OPUmlCompartmentableShape >> removeSeparator [

	separators removeLast remove
]

{ #category : #rendering }
OPUmlCompartmentableShape >> renderBasicShape [

	roassalShape := RSBox new
		                size: 30;
		                model: self;
		                color: Color white;
		                borderColor: Color black;
		                yourself
]

{ #category : #rendering }
OPUmlCompartmentableShape >> renderShapeDetails [

	self roassalShape @ OPRSSelectable.
	self roassalShape @ OPRSSelectionDraggable.
	self roassalShape
		when: RSPositionChangedEvent
		do: [ :event | self layoutContents ]
]

{ #category : #rendering }
OPUmlCompartmentableShape >> rightPadding [

	^ 2
]

{ #category : #accessing }
OPUmlCompartmentableShape >> separators [

	^ separators
]

{ #category : #rendering }
OPUmlCompartmentableShape >> topPadding [

	^ 2
]

{ #category : #rendering }
OPUmlCompartmentableShape >> updateRenderFromModel [

	super updateRenderFromModel.

	self updateSeparators.

	self layout
]

{ #category : #rendering }
OPUmlCompartmentableShape >> updateSeparators [

	[ self separators size < self compartments size ] whileTrue: [ 
		self addSeparator ].

	[ self separators size > self compartments size ] whileTrue: [ 
		self removeSeparator ]
]
