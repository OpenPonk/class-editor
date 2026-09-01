"
I am a bounded container shape representing a UML Package. I render as a tabbed folder icon (with a name tab or ""ear"") and manage the visualization of hidden packages and nested content blocks.
"
Class {
	#name : 'OPUmlPackageShape',
	#superclass : 'OPBoundNode',
	#traits : 'OPTColoredAsFill @ {#updateBasicRoassalShapeColorFromStyles->#updateRoassalShapeColorFromStyles} + OPTUmlPackageableShape',
	#classTraits : 'OPTColoredAsFill classTrait + OPTUmlPackageableShape classTrait',
	#instVars : [
		'nameLabel',
		'stereotypeLabel',
		'ear',
		'innerRoassalShapesBlock'
	],
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'interactions' }
OPUmlPackageShape >> addSelectionDraggableInteraction [

	roassalShape
	@ (OPRSSelectionDraggable thatAlsoDragsShapesProvidedByBlock:
			 innerRoassalShapesBlock)
]

{ #category : 'accessing' }
OPUmlPackageShape >> attachedShapes [

	^ super attachedShapes , {
		  nameLabel.
		  stereotypeLabel.
		  ear }
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

{ #category : 'creating - subelements' }
OPUmlPackageShape >> minHeight [
	^ 60
]

{ #category : 'creating - subelements' }
OPUmlPackageShape >> minWidth [
	^ 120
]

{ #category : 'accessing' }
OPUmlPackageShape >> nameText [

	^ String streamContents: [ :stream |
		  self hiddenPackages do: [ :each |
			  stream << each name asString << '::' ].
		  stream
		  << ((self modelElement name ifNil: [ ' ' ]) ifEmpty: [ ' ' ]) ]
]

{ #category : 'creating - subelements' }
OPUmlPackageShape >> padding [
	^ 40
]

{ #category : 'actions' }
OPUmlPackageShape >> pushBack [

	roassalShape ifNil: [ ^ self ].
	stereotypeLabel pushBack.
	nameLabel pushBack.
	roassalShape pushBack.
	ear pushBack
]

{ #category : 'actions' }
OPUmlPackageShape >> pushFront [

	roassalShape ifNil: [ ^ self ].

	ear pushFront.
	roassalShape pushFront.
	nameLabel pushFront.
	stereotypeLabel pushFront
]

{ #category : 'removing' }
OPUmlPackageShape >> removeRender [

	super removeRender.
	nameLabel := nil.
	stereotypeLabel := nil.
	ear := nil
]

{ #category : 'rendering' }
OPUmlPackageShape >> renderBasicShape [

	^ RSBox new
		  width: self minWidth * 2;
		  height: self minHeight * 2;
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
	nameLabel := RSLabel new
		             color: Color black;
		             model: self;
		             yourself.
	stereotypeLabel := RSLabel new
		                   height: nameLabel height - 2;
		                   color: Color black;
		                   model: self;
		                   yourself.
	self canvas add: nameLabel.
	self canvas add: stereotypeLabel.
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
		stick: nameLabel on: stereotypeLabel.
	nameLabel
		when: RSExtentChangedEvent
		do: [ :event |
			self roassalShape width: {
					self width.
					self minWidth.
					(nameLabel width + self padding) } max ]
		for: self
]

{ #category : 'interactions' }
OPUmlPackageShape >> selectableInteraction [

	^ OPRSSelectable
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

{ #category : 'rendering' }
OPUmlPackageShape >> updateRenderFromModel [

	nameLabel text: self nameText.
	stereotypeLabel text: self stereotypeText.

	super updateRenderFromModel.

	roassalShape signalUpdate
]

{ #category : 'initialization' }
OPUmlPackageShape >> updateRoassalShapeColorFromStyles [

	self updateBasicRoassalShapeColorFromStyles.
	ear color: self color
]
