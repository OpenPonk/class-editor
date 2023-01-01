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
OPUmlRelationshipController >> source [
	^ source
]

{ #category : #accessing }
OPUmlRelationshipController >> source: anObject [
	source := anObject
]
