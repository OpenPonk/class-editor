"
I am a controller for an EnumerationLiteral.
"
Class {
	#name : 'OPUmlEnumerationLiteralController',
	#superclass : 'OPUmlClassifierItemController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'figures' }
OPUmlEnumerationLiteralController >> addDiagramElementToOwner [

	self ownerDiagramElement addLiteral: self diagramElement
]

{ #category : 'construction' }
OPUmlEnumerationLiteralController >> createModelIn: aParentModel [

	^ (super createModelIn: aParentModel)
		  name: self placeholderName;
		  yourself
]

{ #category : 'construction' }
OPUmlEnumerationLiteralController >> dependingOnElements [

	^ super dependingOnElements , (Set with: self model enumeration)
]

{ #category : 'construction' }
OPUmlEnumerationLiteralController >> diagramElementClass [

	^ OPUmlEnumerationLiteralLabel
]

{ #category : 'accessing' }
OPUmlEnumerationLiteralController >> modelClass [
	^ OPUMLEnumerationLiteral
]

{ #category : 'diagram elements' }
OPUmlEnumerationLiteralController >> owner [

	^ diagramController showWithoutDependentInDiagramModel:
		  self model enumeration
]

{ #category : 'hooks' }
OPUmlEnumerationLiteralController >> placeholderName [

	^ 'literal'
]

{ #category : 'construction' }
OPUmlEnumerationLiteralController >> registerModelInContainer: aParentModel [

	aParentModel ownedLiterals add: self model
]

{ #category : 'removing' }
OPUmlEnumerationLiteralController >> removeDiagramElement [

	self diagramElement ifNotExists: [ ^ self ].
	self ownerDiagramElement removeLiteral: self diagramElement.
	self diagramElement: nil
]

{ #category : 'removing' }
OPUmlEnumerationLiteralController >> removeModel [
	"could be any of those, so just nil all of them"

	self model enumeration: nil.
	super removeModel
]
