"
A bounded shape representing a structured UML element with multiple compartments. Coordinates compartment layout, visual dividers, and extent calculation.
"
Class {
	#name : 'OPUmlCompartmentableShape',
	#superclass : 'OPBoundNode',
	#traits : 'OPTUmlAutoAccomodatingShape',
	#classTraits : 'OPTUmlAutoAccomodatingShape classTrait',
	#instVars : [
		'separators'
	],
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'adding' }
OPUmlCompartmentableShape >> addSeparator [

	| newSeparator |
	newSeparator := RSPolyline new.
	newSeparator color: Color black.
	self roassalShape canvas add: newSeparator.
	separators add: newSeparator
]

{ #category : 'accessing' }
OPUmlCompartmentableShape >> attachedShapes [

	^ super attachedShapes , separators
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

{ #category : 'rendering' }
OPUmlCompartmentableShape >> layout [
	(self compartments select: [ :eachCompartment | eachCompartment isRendered ])
		do: [ :eachRenderedCompartment | eachRenderedCompartment accomodateContents ].
	self accomodateContents.
	self layoutContents
]

{ #category : 'rendering' }
OPUmlCompartmentableShape >> layoutContents [

	self layoutOwnedElements.
	self layoutSeparators
]

{ #category : 'rendering' }
OPUmlCompartmentableShape >> layoutOwnedElements [
	| targetWidth |
	targetWidth := self roassalShape width - self leftPadding - self rightPadding.
	(self compartments select: #isRendered) do: [ :eachCompartment |
		eachCompartment width: targetWidth ].
	^ (self ownedElements select: #isRendered)
		inject: self roassalShape encompassingRectangle top + self topPadding
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
		index <= yCoordinates size ifTrue: [
			| y |
			y := yCoordinates at: index.
			each controlPoints: {
				(left @ y).
				(right @ y) } ] ]
]

{ #category : 'initialization' }
OPUmlCompartmentableShape >> recursivelyOwnedElement: aShape renderedIn: aCanvas [

	super recursivelyOwnedElement: aShape renderedIn: aCanvas.
	self isRenderedWithOwnedElements ifTrue: [
		self updateRenderFromModel ]
]

{ #category : 'removing' }
OPUmlCompartmentableShape >> removeRender [

	super removeRender.
	separators do: #remove.
	separators removeAll
]

{ #category : 'removing' }
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

{ #category : 'interactions' }
OPUmlCompartmentableShape >> selectableInteraction [

	^ OPRSSelectable highlightBorderColorBlue
]

{ #category : 'accessing' }
OPUmlCompartmentableShape >> separators [

	^ separators
]

{ #category : 'roassal' }
OPUmlCompartmentableShape >> updateRenderFromBounds [
	super updateRenderFromBounds.
	self isRendered ifTrue: [ self layoutContents ]
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
	| renderedCompartmentsCount |
	renderedCompartmentsCount := (self compartments select: #isRendered) size.
	[ self separators size < renderedCompartmentsCount ] whileTrue: [
		self addSeparator ].
	[ self separators size > renderedCompartmentsCount ] whileTrue: [
		self removeSeparator ]
]
