"
An abstract base edge shape for UML relationships, managing stroke styles, colors, and line markers according to model semantics.
"
Class {
	#name : 'OPUmlEdge',
	#superclass : 'OPEdge',
	#traits : 'OPTColoredAsStroke',
	#classTraits : 'OPTColoredAsStroke classTrait',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'accessing' }
OPUmlEdge >> colorMarker: aMarker [

	aMarker ifNil: [ ^ aMarker ].
	self isRendered ifFalse: [ ^ aMarker ].
	aMarker shape color: self roassalShape color.
	^ aMarker
]

{ #category : 'Roassal2 - accessing' }
OPUmlEdge >> headMarker [

	^ nil
]

{ #category : 'rendering' }
OPUmlEdge >> renderBasicShape [

	^ OPRSPolyline new
		  attachPoint: OPRSOrthogonalBorderAttachPoint new;
		  controlPointsController: OPRSDraggableCPController new;
		  addInteraction: OPRSDraggableControlPoints;
		  color: Color black;
		  from: self source roassalShape;
		  to: self target roassalShape;
		  yourself
]

{ #category : 'Roassal2 - manipulation' }
OPUmlEdge >> switchSourceAndTarget [

	| originalSource originalFrom originalTo |
	originalSource := self source.
	self source: self target.
	self target: originalSource.
	self isRendered ifFalse: [ ^ self ].
	originalFrom := self roassalShape from.
	originalTo := self roassalShape to.
	self roassalShape to: RSBox new. "otherwise old to == new from and old to gets removed"
	self roassalShape from: originalTo.
	self roassalShape to: originalFrom.
	self roassalShape update
]

{ #category : 'Roassal2 - accessing' }
OPUmlEdge >> tailMarker [

	^ nil
]

{ #category : 'rendering' }
OPUmlEdge >> updateRenderFromModel [

	super updateRenderFromModel.

	self roassalShape
		resetMarkers;
		markerEnd: (self colorMarker: self headMarker);
		markerStart: (self colorMarker: self tailMarker).

	self roassalShape signalUpdate
]
