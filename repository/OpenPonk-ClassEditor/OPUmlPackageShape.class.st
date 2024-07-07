"
I represent a package box.
"
Class {
	#name : 'OPUmlPackageShape',
	#superclass : 'OPBoundNode',
	#traits : 'OPTColoredAsFill',
	#classTraits : 'OPTColoredAsFill classTrait',
	#instVars : [
		'mainLabel',
		'stereotypeLabel',
		'ear',
		'innerRoassalShapesBlock'
	],
	#category : 'OpenPonk-ClassEditor-Shapes',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Shapes'
}

{ #category : 'rendering' }
OPUmlPackageShape >> addSelectionDraggableInteraction [

	roassalShape
	@ (OPRSSelectionDraggable thatAlsoDragsShapesProvidedByBlock:
			 innerRoassalShapesBlock)
]

{ #category : 'initialization' }
OPUmlPackageShape >> initialize [

	super initialize.
	innerRoassalShapesBlock := [ :allNodes | allNodes ]
]

{ #category : 'accessing' }
OPUmlPackageShape >> innerRoassalShapesBlock: aBlock [

	innerRoassalShapesBlock := aBlock
]

{ #category : 'accessing' }
OPUmlPackageShape >> labelText [

	^ self modelElement name
]

{ #category : 'creating - subelements' }
OPUmlPackageShape >> minHeight [
	^ 60
]

{ #category : 'creating - subelements' }
OPUmlPackageShape >> minWidth [
	^ 120
]

{ #category : 'creating - subelements' }
OPUmlPackageShape >> padding [
	^ 40
]

{ #category : 'update' }
OPUmlPackageShape >> pushBack [

	stereotypeLabel pushBack.
	mainLabel pushBack.
	roassalShape pushBack.
	ear pushBack
]

{ #category : 'rendering' }
OPUmlPackageShape >> renderBasicShape [

	^ RSBox new
		  width: self minWidth;
		  height: self minHeight;
		  color: self fillColor;
		  borderColor: Color black;
		  yourself
]

{ #category : 'rendering' }
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
		insideCornerLeft;
		offset: 0 @ self roassalShape border width;
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

{ #category : 'rendering' }
OPUmlPackageShape >> selectableInteraction [

	^ OPRSSelectable
]

{ #category : 'rendering' }
OPUmlPackageShape >> shouldBePositionableByUser [

	^ true
]

{ #category : 'interactions' }
OPUmlPackageShape >> shouldBeResizableByUser [

	^ true
]

{ #category : 'accessing' }
OPUmlPackageShape >> stereotypeText [

	^ (self modelElement oclIsKindOf: #Profile)
		  ifTrue: [ '«profile»' ]
		  ifFalse: [ '' ]
]

{ #category : 'update' }
OPUmlPackageShape >> updateColorFromStyles [

	self roassalShape
		propertyAt: OPRSSelectable
		ifPresent: [ :selectable |
			| key |
			key := selectable copyKey , 'color'.
			self roassalShape properties at: key ifPresent: [
				self roassalShape properties
					at: key
					put: (OrderedCollection with: self color).
				^ self ] ].
	self roassalShape color: self color.
	ear color: self color
]

{ #category : 'update' }
OPUmlPackageShape >> updateRenderFromModel [

	mainLabel text: self labelText.
	stereotypeLabel text: self stereotypeText.

	super updateRenderFromModel.

	roassalShape signalUpdate
]
