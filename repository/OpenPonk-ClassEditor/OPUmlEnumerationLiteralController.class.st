"
I am a controller for an EnumerationLiteral.
"
Class {
	#name : #OPUmlEnumerationLiteralController,
	#superclass : #OPUmlElementController,
	#instVars : [
		'classController'
	],
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #figures }
OPUmlEnumerationLiteralController >> createDiagramElement [
	^ OPUmlLabel new
		modelElement: self model;
		text: [ :aModel | aModel name ];
		localStyle: OPUmlStyle new;
		yourself
]

{ #category : #construction }
OPUmlEnumerationLiteralController >> createModelIn: aClassifierController andShowInDiagram: aDiagramController [
	| newModel |
	newModel := self modelClass new.
	newModel name: 'literal'.
	self model: newModel.
	aClassifierController model ownedLiterals add: model.
	aDiagramController addController: self.
	self showInDiagram: aDiagramController
]

{ #category : #accessing }
OPUmlEnumerationLiteralController >> modelClass [
	^ OPUMLEnumerationLiteral
]

{ #category : #figures }
OPUmlEnumerationLiteralController >> refreshFigure [
	self diagramElement changed.
	self diagramElement owningElement owningElement changed
]

{ #category : #removing }
OPUmlEnumerationLiteralController >> removeModel [
	self remove.
	"could be any of those, so just nil all of them"
	model owningClass: nil.
	model datatype: nil.
	model interface: nil
]

{ #category : #figures }
OPUmlEnumerationLiteralController >> renderFigureIn: aView [
	diagramElement := self createDiagramElement.
	diagramElement
		owningElement: (diagramController controllerForModel: model enumeration) diagramElement attributes.
	diagramElement renderIn: aView.
	diagramController figureAdded: self figure.
	self refreshFigure
]

{ #category : #figures }
OPUmlEnumerationLiteralController >> showInDiagram: aDiagramController [
	aDiagramController addController: self.
	self renderFigureIn: aDiagramController view
]
