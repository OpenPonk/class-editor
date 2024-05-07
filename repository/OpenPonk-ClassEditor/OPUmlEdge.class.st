Class {
	#name : 'OPUmlEdge',
	#superclass : 'OPEdge',
	#traits : 'OPTColoredAsStroke',
	#classTraits : 'OPTColoredAsStroke classTrait',
	#category : 'OpenPonk-ClassEditor-Shapes',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Shapes'
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

	| originalSource originalFrom originalTo memberEnds |
	originalSource := self source.
	self source: self target.
	self target: originalSource.
	originalFrom := self roassalShape from.
	originalTo := self roassalShape to.
	self roassalShape to: RSBox new. "otherwise old to == new from and old to gets removed"
	self roassalShape from: originalTo.
	self roassalShape to: originalFrom.
	memberEnds := self modelElement memberEnds asArray.
	self ownedElements
		select: [ :each | memberEnds includes: each modelElement ]
		thenDo: [ :each |
			each modelElement:
				(memberEnds at: 3 - (memberEnds indexOf: each modelElement)) ].
	self roassalShape update.
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
