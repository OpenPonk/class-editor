"
I am a base class for diagram element controllers.
"
Class {
	#name : #OPUmlElementController,
	#superclass : #OPElementController,
	#traits : 'OPTUmlStereotypedElementController',
	#classTraits : 'OPTUmlStereotypedElementController classTrait',
	#instVars : [
		'diagramElement'
	],
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #forms }
OPUmlElementController >> buildAbstractEditorForm: aForm [
	(aForm addCheckbox: 'Is Abstract')
		state: self model isAbstract;
		whenChangedDo: [ :val | 
			self model isAbstract: val.
			self refreshFigure ]
]

{ #category : #figures }
OPUmlElementController >> createDiagramElement [
	^ self subclassResponsibility
]

{ #category : #figures }
OPUmlElementController >> createFigure [
	^ self shouldNotImplement
]

{ #category : #figures }
OPUmlElementController >> diagramElement [
	^ diagramElement
]

{ #category : #figures }
OPUmlElementController >> figure [
	^ self diagramElement rtElement
]

{ #category : #accessing }
OPUmlElementController >> magritteDescription [
	| container |
	container := MAPragmaBuilder for: self.
	container addAll: self stereotypeMagritteDescription.
	^ container
]

{ #category : #hooks }
OPUmlElementController >> reactToAttributeWrite [
	diagramElement ifNotNil: [ self refreshFigure ]
]

{ #category : #figures }
OPUmlElementController >> removeDiagramElement [
	self diagramController deselectAll.
	diagramElement view
		ifNotNil: [ 
			diagramElement remove.
			diagramElement := nil ]
]

{ #category : #figures }
OPUmlElementController >> removeFigure [
	self removeDiagramElement
]

{ #category : #model }
OPUmlElementController >> removeModel [
	self subclassResponsibility
	
]

{ #category : #figures }
OPUmlElementController >> renderFigureIn: aView [
	self subclassResponsibility
]
