"
I am an abstract controller for relationship-type elements.
"
Class {
	#name : #OPUmlRelationshipController,
	#superclass : #OPUmlElementController,
	#traits : 'OPTRelationshipWithPathPointsController',
	#classTraits : 'OPTRelationshipWithPathPointsController classTrait',
	#instVars : [
		'source'
	],
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #figures }
OPUmlRelationshipController >> connectionFeedback [
	^ OPInteractiveLine new
		lineBuilder: [ :fromFigure :toFigure | RTLine edgeFrom: fromFigure to: toFigure ];
		from: source figure
]

{ #category : #accessing }
OPUmlRelationshipController >> figure [
	^ diagramElement rtEdge
]

{ #category : #testing }
OPUmlRelationshipController >> isHideable [
	^ true
]

{ #category : #accessing }
OPUmlRelationshipController >> layout [
	self figure shape ifNil: [ ^ OPElementLayout none ].
	(self figure shape isKindOf: OPRTConnection)
		ifFalse: [ ^ OPElementLayout none ].
	^ (self figure shape pathFor: self figure)
		ifNil: [ OPElementLayout none ]
		ifNotNil: [ :pathPoints | 
			OPElementLayout
				withPathFromSource: self pathSourceModel uuid
				throughPoints: pathPoints ]
]

{ #category : #accessing }
OPUmlRelationshipController >> layout: aLayout [
	| router innerPoints pathPoints path |
	aLayout ifNil: [ ^ self ].
	path := aLayout path.
	path ifNil: [ ^ self ].
	pathPoints := path points.
	pathPoints ifNil: [ ^ self ].
	self figure shape ifNil: [ ^ self ].
	router := self figure shape router.
	router removeAll.
	innerPoints := pathPoints size < 2
		ifTrue: [ pathPoints ]
		ifFalse: [ pathPoints copyFrom: 2 to: pathPoints size - 1 ].
	self pathSourceModel uuid = path source
		ifFalse: [ innerPoints := innerPoints reversed ].
	innerPoints do: [ :each | router addPoint: each ]
]

{ #category : #accessing }
OPUmlRelationshipController >> source [
	^ source
]

{ #category : #accessing }
OPUmlRelationshipController >> source: anObject [
	source := anObject
]
