"
I represent a package box.
"
Class {
	#name : #OPUmlPackageShape,
	#superclass : #RTAbstractMultiElement,
	#instVars : [
		'labelText',
		'stereotypeText',
		'showTriangle',
		'style'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #adding }
OPUmlPackageShape >> addInteractions [
	self @ RTDraggable.
	self @ (RTResizable new minSize: self minWidth @ self minHeight)
]

{ #category : #accessing }
OPUmlPackageShape >> baseShape [
	^ RTBox new
		width: self minWidth;
		height: self minHeight;
		fillColor: Color white;
		borderColor: Color black
]

{ #category : #'creating - subelements' }
OPUmlPackageShape >> createOwnedElements [
	| mainLabel triangle ear mainStereotype earOverlay |
	ear := RTBox new
		width: self minWidth * self earScaling;
		height: 25;
		fillColor: [ self shape colorFor: self ];
		borderColor: [ self shape borderColorFor: self ];
		elementOn: self.
	self add: ear.
	triangle := RTSVGPath new
		path: 'M0,0L10,-10L20,0z';
		fillColor: [ :aModel | 
			self showTriangle
				ifTrue: [ Color veryVeryLightGray ]
				ifFalse: [ Color transparent ] ];
		borderColor: [ :aModel | 
			self showTriangle
				ifTrue: [ self shape borderColorFor: self ]
				ifFalse: [ Color transparent ] ];
		"		vertices: (Array with: 0 @ 0 with: 10 @ -10 with: 20 @ 0);"
			elementOn: self.
	self add: triangle.
	mainLabel := RTLabel new
		text: #labelText;
		color: [ self fontColor ];
		elementOn: self.
	self add: mainLabel.
	mainStereotype := RTLabel new
		text: #stereotypeText;
		height: (mainLabel shape heightFor: mainLabel) - 2;
		color: [ self fontColor ];
		elementOn: self.
	self add: mainStereotype.
	(RTConstraint on: ear background: self)
		top;
		left;
		verticalPadding: ear height negated;
		stick.
	(RTConstraint on: triangle background: self)
		top;
		right;
		padding: 15;
		stick.
	(RTConstraint on: mainLabel background: self) stick.
	(RTConstraint on: mainStereotype background: mainLabel)
		top;
		outer;
		stick.
	self
		addCallback: (TRExtentCallback block: [ :sh :st | ear width: self width * self earScaling ]).
	mainLabel
		addCallback:
			(TRExtentCallback
				block: [ :sh :st | 
					| width |
					width := {self minWidth.
					mainLabel width + self padding} max.
					self shape width: width.
					ear width: width * self earScaling ])
]

{ #category : #'creating - subelements' }
OPUmlPackageShape >> earScaling [
	^ 0.6
]

{ #category : #'creating - subelements' }
OPUmlPackageShape >> fontColor [
	^ style ifNil: [ Color black ] ifNotNil: #fontColor
]

{ #category : #initialization }
OPUmlPackageShape >> initialize [
	self stereotypeText: [ :aModel | '' ].
	self labelText: [ :aModel | 'nil' ].
	self showTriangle: [ :aModel | false ].
	super initialize
]

{ #category : #accessing }
OPUmlPackageShape >> labelText [
	^ labelText value: model
]

{ #category : #accessing }
OPUmlPackageShape >> labelText: aBlock [
	labelText := aBlock
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

{ #category : #accessing }
OPUmlPackageShape >> showTriangle [
	^ showTriangle value: model
]

{ #category : #'creating - subelements' }
OPUmlPackageShape >> showTriangle: aBlock [
	showTriangle := aBlock
]

{ #category : #accessing }
OPUmlPackageShape >> stereotypeText [
	^ stereotypeText value: model
]

{ #category : #'creating - subelements' }
OPUmlPackageShape >> stereotypeText: aBlock [
	stereotypeText := aBlock
]

{ #category : #accessing }
OPUmlPackageShape >> style [
	^ style
]

{ #category : #accessing }
OPUmlPackageShape >> style: anObject [
	style := anObject
]
