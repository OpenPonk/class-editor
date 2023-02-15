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

{ #category : #initialization }
OPUmlPackageImportShape >> createConnection [
	^ (OPRTStyledConnection new
		attachPoint: (OPRTOrthogonalAttachPoint new offset: 30);
		color: self style strokeColor;
		head: (self headDecorator asHead color: Color yellow);
		tail: self tailDecorator asTail;
		width: self style strokeWidth;
		decorate: [ :deco | deco dashedLine ];
		edgeFrom: source roassalShape to: target roassalShape)
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
