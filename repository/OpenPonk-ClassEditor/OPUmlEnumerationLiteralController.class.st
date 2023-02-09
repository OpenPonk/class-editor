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

{ #category : #construction }
OPUmlEnumerationLiteralController >> createModelIn: aParentModel [
	self
		model:
			(self modelClass new
				name: 'literal';
				yourself).
	aParentModel ownedLiterals add: model.
	^ model
]

{ #category : #construction }
OPUmlEnumerationLiteralController >> diagramElementClass [

	^ OPUmlEnumerationLiteralLabel
]

{ #category : #'as yet unclassified' }
OPUmlEnumerationLiteralController >> diagramElementOwner [

^ self halt
]

{ #category : #accessing }
OPUmlEnumerationLiteralController >> modelClass [
	^ OPUMLEnumerationLiteral
]

{ #category : #figures }
OPUmlEnumerationLiteralController >> refreshFigure [
	self diagramElement changed.
	self diagramElement owningElement owningElement changed.
	^ self figure
]

{ #category : #removing }
OPUmlEnumerationLiteralController >> removeModel [
	"could be any of those, so just nil all of them"

	model enumeration: nil
]

{ #category : #figures }
OPUmlEnumerationLiteralController >> renderFigureIn: aView [
	self diagramController addingFigureFor: self.
	diagramElement := self createDiagramElement.
	diagramElement
		owningElement:
			(diagramController diagramElementForModel: model enumeration)
				attributes.
	diagramElement renderIn: aView.
	diagramController addedFigureFor: self.
	^ self refreshFigure
]
