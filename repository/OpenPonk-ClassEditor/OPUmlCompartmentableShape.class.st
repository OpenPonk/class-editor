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
	newSeparator := RSLine new.
	self roassalShape canvas add: newSeparator.
	separators add: newSeparator
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

	^ self ownedElements inject: 0 into: [ :prevHeight :each | 
		  each translateTopTo: prevHeight.
		  prevHeight + each height + 1 ]
]

{ #category : #rendering }
OPUmlCompartmentableShape >> layoutSeparators [

	| yCoordinates left right |
	yCoordinates := self compartments collect: [ :each | each top ].

	left := self roassalShape encompassingRectangle left.
	right := self roassalShape encompassingRectangle right.

	self separators withIndexDo: [ :each :index | 
		| y |
		y := yCoordinates at: index.
		each controlPoints: { 
				(left @ y).
				(right @ y) } ]
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

{ #category : #accessing }
OPUmlCompartmentableShape >> separators [

	^ separators
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
