Class {
	#name : #OPUmlEdge,
	#superclass : #OPEdge,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #accessing }
OPUmlEdge >> colorMarker: aMarker [

	aMarker ifNil: [ ^ aMarker ].
	self isRendered ifFalse: [ ^ aMarker ].
	aMarker shape color: self roassalShape color.
	^ aMarker
]

{ #category : #'Roassal2 - accessing' }
OPUmlEdge >> headMarker [

	^ nil
]

{ #category : #rendering }
OPUmlEdge >> renderBasicShape [

	^ OPRSPolyline new
		  withBorderAttachPoint;
		  controlPointsController: OPRSDraggableCPController new;
		  addInteraction: OPRSDraggableControlPoints;
		  color: Color black;
		  from: self source roassalShape;
		  to: self target roassalShape;
		  yourself
]

{ #category : #accessing }
OPUmlEdge >> strokeColor [

	^ self stylePropertyNamed: #strokeColor ifAbsent: [ Color black ]
]

{ #category : #accessing }
OPUmlEdge >> strokeColor: aColor [

	^ self stylePropertyNamed: #strokeColor put: aColor
]

{ #category : #'Roassal2 - manipulation' }
OPUmlEdge >> switchSourceAndTarget [

	| originalSource originalFrom originalTo |
	originalSource := self source.
	self source: self target.
	self target: originalSource.
	originalFrom := self roassalShape from.
	originalTo := self roassalShape to.
	self roassalShape to: RSBox new. "otherwise old to == new from and old to gets removed"
	self roassalShape from: originalTo.
	self roassalShape to: originalFrom
]

{ #category : #'Roassal2 - accessing' }
OPUmlEdge >> tailMarker [

	^ nil
]

{ #category : #rendering }
OPUmlEdge >> updateRenderFromModel [

	super updateRenderFromModel.

	self roassalShape
		resetMarkers;
		markerEnd: (self colorMarker: self headMarker);
		markerStart: (self colorMarker: self tailMarker).

	self roassalShape signalUpdate
]

{ #category : #update }
OPUmlEdge >> updateRenderFromStyles [

	self isRendered ifFalse: [ ^ self ].
	roassalShape color: self strokeColor.
	super updateRenderFromStyles.
	self roassalShape signalUpdate
]
