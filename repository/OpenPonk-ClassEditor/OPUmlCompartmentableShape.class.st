Class {
	#name : 'OPUmlCompartmentableShape',
	#superclass : 'OPBoundNode',
	#traits : 'OPTUmlAutoAccomodatingShape',
	#classTraits : 'OPTUmlAutoAccomodatingShape classTrait',
	#instVars : [
		'separators'
	],
	#category : 'OpenPonk-ClassEditor-Shapes',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Shapes'
}

{ #category : 'accessing' }
OPUmlCompartmentableShape >> addSeparator [

	| newSeparator |
	newSeparator := RSPolyline new.
	newSeparator color: Color black.
	self roassalShape canvas add: newSeparator.
	separators add: newSeparator
]

{ #category : 'accessing' }
OPUmlCompartmentableShape >> compartments [

	^ self ownedElements select: [ :each | each isKindOf: OPUmlCompartment ]
]

{ #category : 'initialization' }
OPUmlCompartmentableShape >> initialize [

	super initialize.
	separators := OrderedCollection new
]

{ #category : 'as yet unclassified' }
OPUmlCompartmentableShape >> isResizableByUser [

	^ false
]

{ #category : 'rendering' }
OPUmlCompartmentableShape >> layout [

	self
		accomodateContents;
		layoutContents
]

{ #category : 'rendering' }
OPUmlCompartmentableShape >> layoutContents [

	self layoutOwnedElements.
	self layoutSeparators
]

{ #category : 'rendering' }
OPUmlCompartmentableShape >> layoutOwnedElements [

	^ (self ownedElements select: #isRendered)
		  inject:
		  self roassalShape encompassingRectangle top + self topPadding
		  into: [ :prevHeight :each | 
			  each translateTopTo: prevHeight.
			  prevHeight + each height + 1 ]
]

{ #category : 'rendering' }
OPUmlCompartmentableShape >> layoutSeparators [

	| yCoordinates left right |
	yCoordinates := (self compartments ifEmpty: [ ^ self ])
		                select: #isRendered
		                thenCollect: [ :each | each top ].

	left := self roassalShape encompassingRectangle left.
	right := self roassalShape encompassingRectangle right.

	self separators withIndexDo: [ :each :index | 
		| y |
		y := yCoordinates at: index.
		each controlPoints: { 
				(left @ y).
				(right @ y) } ]
]

{ #category : 'as yet unclassified' }
OPUmlCompartmentableShape >> ownedElement: aShape renderedIn: aCanvas [

	| wasRendered |
	wasRendered := self isRenderedWithOwnedElements.
	super ownedElement: aShape renderedIn: aCanvas.
	wasRendered ifTrue: [ self updateRenderFromModel ]
]

{ #category : 'removing' }
OPUmlCompartmentableShape >> removeRender [

	super removeRender.
	separators do: #remove.
	separators := OrderedCollection new
]

{ #category : 'accessing' }
OPUmlCompartmentableShape >> removeSeparator [

	separators removeLast remove
]

{ #category : 'rendering' }
OPUmlCompartmentableShape >> renderBasicShape [

	^ RSBox new
		  size: 30;
		  yourself
]

{ #category : 'rendering' }
OPUmlCompartmentableShape >> renderShapeDetails [

	super renderShapeDetails.
	self roassalShape
		when: RSPositionChangedEvent
		do: [ :event | self layoutContents ]
		for: self
]

{ #category : 'rendering' }
OPUmlCompartmentableShape >> selectableInteraction [

	^ OPRSSelectable highlightBorderColorBlue
]

{ #category : 'accessing' }
OPUmlCompartmentableShape >> separators [

	^ separators
]

{ #category : 'rendering' }
OPUmlCompartmentableShape >> shouldBePositionableByUser [

	^ true
]

{ #category : 'rendering' }
OPUmlCompartmentableShape >> updateRenderFromModel [

	super updateRenderFromModel.

	self updateSeparators.

	self layout.

	roassalShape signalUpdate
]

{ #category : 'rendering' }
OPUmlCompartmentableShape >> updateSeparators [

	[ self separators size < self compartments size ] whileTrue: [ 
		self addSeparator ].

	[ self separators size > self compartments size ] whileTrue: [ 
		self removeSeparator ]
]
