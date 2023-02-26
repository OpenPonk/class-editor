Class {
	#name : #OPUmlEdge,
	#superclass : #OPEdge,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #'Roassal2 - accessing' }
OPUmlEdge >> headMarker [

	^ nil
]

{ #category : #rendering }
OPUmlEdge >> renderBasicShape [

	^ OPRSPolyline new
		  markerEnd: self headMarker;
		  markerStart: self tailMarker;
		  withBorderAttachPoint;
		  controlPointsController: OPRSDraggableCPController new;
		  addInteraction: OPRSDraggableControlPoints;
		  color: Color black;
		  from: self source roassalShape;
		  to: self target roassalShape;
		  yourself
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
