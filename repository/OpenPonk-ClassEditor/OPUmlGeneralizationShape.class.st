"
I represent a direct generalization line.
"
Class {
	#name : #OPUmlGeneralizationShape,
	#superclass : #OPUmlEdge,
	#instVars : [
		'nameLabel',
		'constraints'
	],
	#category : #'OpenPonk-ClassEditor-Shapes'
}

{ #category : #configuration }
OPUmlGeneralizationShape >> addConstraintsTo: aCollection at: aPosition [
	aCollection add: (self constraintLabel: nameLabel at: aPosition side: -1)
]

{ #category : #configuration }
OPUmlGeneralizationShape >> constraintLabel: aLabel at: aPosition side: aSide [
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
OPUmlGeneralizationShape >> initialize [

	super initialize.
	self headDecorator: OPUmlEdgeMarkers arrow.
	nameLabel := OPUmlGeneralizationLabel
		             in: self
		             forModelElement: self modelElement.
	constraints := OrderedCollection new
]

{ #category : #accessing }
OPUmlGeneralizationShape >> markerFor: aProperty [

	aProperty opposite aggregation = OPUMLAggregationKind composite 
		ifTrue: [ ^ OPUmlEdgeMarkers filledDiamond ].
	aProperty opposite aggregation = OPUMLAggregationKind shared ifTrue: [ 
		^ OPUmlEdgeMarkers emptyDiamond ].
	aProperty isNavigable ifTrue: [ ^ OPUmlEdgeMarkers simpleArrow ].
	^ OPUmlEdgeMarkers none
]

{ #category : #accessing }
OPUmlGeneralizationShape >> modelElement: anObject [
	super modelElement: anObject.
	nameLabel modelElement: anObject.
]

{ #category : #rendering }
OPUmlGeneralizationShape >> renderIn: aView [
	super renderIn: aView.
	self addConstraintsTo: constraints at: #middle.
	self ownedElements do: [ :each | each renderIn: view ].
	constraints do: #build.
	self update
]

{ #category : #testing }
OPUmlGeneralizationShape >> showIncomplete [
	^ false
]

{ #category : #testing }
OPUmlGeneralizationShape >> showOverlapping [
	^ false
]

{ #category : #'Roassal2 - updating' }
OPUmlGeneralizationShape >> update [
	self rtEdge shape color: self style strokeColor.
	self rtEdge update.
	constraints do: #update.
	self ownedElements do: #update
]
