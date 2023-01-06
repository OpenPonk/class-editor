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

	^ OPRSInteractiveLine new
		  lineBuilder: [ :fromFigure :toFigure | 
			  RSLine new
				  from: fromFigure;
				  to: toFigure;
				  yourself ];
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
