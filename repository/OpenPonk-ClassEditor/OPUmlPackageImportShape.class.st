"
I represent a import line from importing to imported package.
"
Class {
	#name : #OPUmlPackageImportShape,
	#superclass : #OPUmlEdge,
	#instVars : [
		'nameLabel',
		'constraints'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #configuration }
OPUmlPackageImportShape >> addConstraintsTo: aCollection at: aPosition [
	aCollection add: (self constraintLabel: nameLabel at: aPosition side: -1)
]

{ #category : #configuration }
OPUmlPackageImportShape >> constraintLabel: aLabel at: aPosition side: aSide [
	| config anchor |
	config := Dictionary
		with: #source -> (Array with: 10 with: aSide * 10)
		with: #target -> (Array with: -10 with: aSide * 10)
		with: #middle -> (Array with: 0.5 with: 0).
	anchor := OPRTAnchorConstraint new.
	anchor
		element: aLabel rtElement;
		edge: self rtEdge;
		balance: (config at: aPosition) first;
		minDistance: (config at: aPosition) second.
	^ anchor
]

{ #category : #initialization }
OPUmlPackageImportShape >> createConnection [
	^ (OPRTStyledConnection new
		attachPoint: (OPRTOrthogonalAttachPoint new offset: 30);
		color: self style strokeColor;
		head: (self headDecorator asHead color: Color yellow);
		tail: self tailDecorator asTail;
		width: self style strokeWidth;
		decorate: [ :deco | deco dashedLine ];
		edgeFrom: source rtElement to: target rtElement)
		model: self;
		yourself
]

{ #category : #initialization }
OPUmlPackageImportShape >> createRtEdge [
	^ super createRtEdge
		in: [ :edge | edge shape decorate: [ :deco | deco dashdotLine ] ];
		yourself
]

{ #category : #initialization }
OPUmlPackageImportShape >> initialize [

	super initialize.
	self headDecorator: OPUmlEdgeMarkers simpleArrow.
	nameLabel := OPUmlPackageImportLabel
		             in: self
		             forModelElement: self modelElement.
	constraints := OrderedCollection new
]

{ #category : #accessing }
OPUmlPackageImportShape >> modelElement: anObject [
	super modelElement: anObject.
	nameLabel modelElement: anObject.
]

{ #category : #rendering }
OPUmlPackageImportShape >> renderIn: aView [
	super renderIn: aView.
	self addConstraintsTo: constraints at: #middle.
	self ownedElements do: [ :each | each renderIn: view ].
	constraints do: #build.
	self update
]

{ #category : #testing }
OPUmlPackageImportShape >> showIncomplete [
	^ false
]

{ #category : #testing }
OPUmlPackageImportShape >> showOverlapping [
	^ false
]

{ #category : #'Roassal2 - updating' }
OPUmlPackageImportShape >> update [
	self rtEdge update.
	constraints do: #update.
	self ownedElements do: #update
]
