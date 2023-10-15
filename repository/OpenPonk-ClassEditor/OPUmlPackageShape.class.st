"
I represent a package box.
"
Class {
	#name : #OPUmlPackageShape,
	#superclass : #OPShape,
	#traits : 'OPTDIColoredAsFill',
	#classTraits : 'OPTDIColoredAsFill classTrait',
	#instVars : [
		'mainLabel',
		'stereotypeLabel',
		'ear',
		'innerRoassalShapesBlock'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #rendering }
OPUmlPackageShape >> addSelectionDraggableInteraction [

	roassalShape
	@ (OPRSSelectionDraggable thatAlsoDragsShapesProvidedByBlock:
			 innerRoassalShapesBlock)
]

{ #category : #initialization }
OPUmlPackageShape >> initialize [

	super initialize.
	innerRoassalShapesBlock := [ :allNodes | allNodes ]
]

{ #category : #accessing }
OPUmlPackageShape >> innerRoassalShapesBlock: aBlock [

	innerRoassalShapesBlock := aBlock
]

{ #category : #accessing }
OPUmlPackageShape >> labelText [

	^ self modelElement name
]

{ #category : #'creating - subelements' }
OPUmlPackageShape >> minHeight [
	^ 60
]

{ #category : #'creating - subelements' }
OPUmlPackageShape >> minWidth [
	^ 120
]

{ #category : #'creating - subelements' }
OPUmlPackageShape >> padding [
	^ 40
]

{ #category : #rendering }
OPUmlPackageShape >> renderBasicShape [

	^ RSBox new
		  width: self minWidth;
		  height: self minHeight;
		  color: self color;
		  borderColor: Color black;
		  yourself
]

{ #category : #rendering }
OPUmlPackageShape >> renderShapeDetails [

	ear := RSBox new
		       width: 35;
		       height: 15;
		       color: self roassalShape color;
		       borderColor: self roassalShape borderColor;
		       model: self;
		       yourself.
	self canvas add: ear.
	self roassalShape
		when: RSShapeRemovedEvent
		do: [ ear remove ]
		for: self.
	mainLabel := RSLabel new
		             color: Color black;
		             model: self;
		             yourself.
	stereotypeLabel := RSLabel new
		                   height: mainLabel height - 2;
		                   color: Color black;
		                   model: self;
		                   yourself.
	self canvas add: mainLabel.
	self canvas add: stereotypeLabel.
	self roassalShape
		when: RSShapeRemovedEvent
		do: [
			mainLabel remove.
			stereotypeLabel remove ]
		for: self.
	RSLocation new
		inner;
		left;
		top;
		offset: 0 @ ear height negated;
		stick: ear on: self roassalShape.
	RSLocation new
		inner;
		top;
		stick: stereotypeLabel on: self roassalShape.
	RSLocation new
		outer;
		below;
		stick: mainLabel on: stereotypeLabel.
	mainLabel
		when: RSExtentChangedEvent
		do: [ :event |
			self roassalShape width: {
					self width.
					self minWidth.
					(mainLabel width + self padding) } max ]
		for: self
]

{ #category : #rendering }
OPUmlPackageShape >> selectableInteraction [

	^ OPRSSelectable
]

{ #category : #rendering }
OPUmlPackageShape >> shouldBePositionableByUser [

	^ true
]

{ #category : #interactions }
OPUmlPackageShape >> shouldBeResizableByUser [

	^ true
]

{ #category : #accessing }
OPUmlPackageShape >> stereotypeText [

	^ (self modelElement oclIsKindOf: #Profile)
		  ifTrue: [ '«profile»' ]
		  ifFalse: [ '' ]
]

{ #category : #update }
OPUmlPackageShape >> updateRenderFromModel [

	mainLabel text: self labelText.
	stereotypeLabel text: self stereotypeText.

	super updateRenderFromModel.

	roassalShape signalUpdate
]

{ #category : #update }
OPUmlPackageShape >> updateRenderFromStyles [

	self isRendered ifFalse: [ ^ self ].
	roassalShape color: self color.
	ear color: self color.
	super updateRenderFromStyles.
	self roassalShape signalUpdate
]
