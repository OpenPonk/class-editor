"
I am an abstract controller for relationship-type elements.
"
Class {
	#name : #OPUmlRelationshipController,
	#superclass : #OPUmlElementController,
	#instVars : [
		'sourceController'
	],
	#category : 'OpenPonk-ClassEditor-Controllers'
}

{ #category : #figures }
OPUmlRelationshipController >> connectionFeedback [
	^ OPInteractiveLine new
		lineBuilder: [ :fromFigure :toFigure | RTLine edgeFrom: fromFigure to: toFigure ];
		from: sourceController figure
]

{ #category : #accessing }
OPUmlRelationshipController >> figure [
	^ diagramElement rtEdge
]

{ #category : #forms }
OPUmlRelationshipController >> layout [
	^ nil
]

{ #category : #forms }
OPUmlRelationshipController >> layout: aPoint [
	
]

{ #category : #figures }
OPUmlRelationshipController >> showInDiagram: aDiagramController [
	self renderFigureIn: aDiagramController view
]

{ #category : #accessing }
OPUmlRelationshipController >> sourceController [
	^ sourceController
]

{ #category : #accessing }
OPUmlRelationshipController >> sourceController: anObject [
	sourceController := anObject
]
