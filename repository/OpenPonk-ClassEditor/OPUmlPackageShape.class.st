"
I represent a package box.
"
Class {
	#name : #OPUmlPackageShape,
	#superclass : #OPShape,
	#instVars : [
		'mainLabel',
		'stereotypeLabel',
		'ear'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #accessing }
OPUmlPackageShape >> color [

	^ self stylePropertyNamed: #fillColor ifAbsent: [ Color veryVeryLightGray ]
]

{ #category : #accessing }
OPUmlPackageShape >> color: aColor [

	^ self stylePropertyNamed: #fillColor put: aColor
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
		  color: Color veryVeryLightGray;
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
	self roassalShape when: RSShapeRemovedEvent do: [ 
		mainLabel remove.
		stereotypeLabel remove ].
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
	mainLabel when: RSExtentChangedEvent do: [ :event | 
		self roassalShape width: { 
				self width.
				self minWidth.
				(mainLabel width + self padding) } max ].

	self roassalShape
		@ OPRSSelectable;
		@
			(OPRSSelectionDraggable thatDragsInnerShapesOnCondition: [ :shape | 
					 self shouldDragInnerShape: shape ]);
		@ OPRSResizable
]

{ #category : #'creating - subelements' }
OPUmlPackageShape >> shouldDragInnerShape: aShape [

	| innerShapeDiagramElement |
	innerShapeDiagramElement := aShape model ifNil: [ ^ false ].
	(innerShapeDiagramElement isKindOf: OPDiagramElement) ifFalse: [ 
		^ false ].
	^ self modelElement hasPackagedElement:
		  (innerShapeDiagramElement modelElement ifNil: [ ^ false ])
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
OPUmlPackageShape >> updateRenderFromSelf [

	self isRendered ifFalse: [ ^ self ].
	roassalShape color: self color.
	ear color: self color.
	super updateRenderFromSelf
]
