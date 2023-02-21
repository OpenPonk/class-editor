"
I am a controller for an EnumerationLiteral.
"
Class {
	#name : #OPUmlEnumerationLiteralController,
	#superclass : #OPUmlClassifierItemController,
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #figures }
OPUmlEnumerationLiteralController >> addDiagramElementToOwner [

	self diagramElementOwner addLiteral: diagramElement
]

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

	^ (diagramController showWithoutDependentInDiagramModel:
		   model enumeration) diagramElement
]

{ #category : #accessing }
OPUmlEnumerationLiteralController >> modelClass [
	^ OPUMLEnumerationLiteral
]

{ #category : #removing }
OPUmlEnumerationLiteralController >> removeDiagramElement [

	self diagramElement ifNil: [ ^ self ].
	self diagramElementOwner removeLiteral: self diagramElement.
	diagramElement := nil
]

{ #category : #removing }
OPUmlEnumerationLiteralController >> removeModel [
	"could be any of those, so just nil all of them"

	model enumeration: nil
]
