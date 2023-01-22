"
I am a base class for diagram element controllers.
"
Class {
	#name : #OPUmlElementController,
	#superclass : #OPElementController,
	#traits : 'OPTUmlStereotypedElementController',
	#classTraits : 'OPTUmlStereotypedElementController classTrait',
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
