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

	self ownerDiagramElement addLiteral: diagramElement
]

{ #category : 'construction' }
OPUmlEnumerationLiteralController >> createModelIn: aParentModel [

	^ (super createModelIn: aParentModel)
		  name: self placeholderName;
		  yourself
]

{ #category : 'construction' }
OPUmlEnumerationLiteralController >> dependingOnElements [

	^ super dependingOnElements , (Set with: model enumeration)
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
		  model enumeration
]

{ #category : 'hooks' }
OPUmlEnumerationLiteralController >> placeholderName [

	^ 'literal'
]

{ #category : 'construction' }
OPUmlEnumerationLiteralController >> registerModelInContainer: aParentModel [

	aParentModel ownedLiterals add: model
]

{ #category : 'removing' }
OPUmlEnumerationLiteralController >> removeDiagramElement [

	self diagramElement ifNotExists: [ ^ self ].
	self ownerDiagramElement removeLiteral: self diagramElement.
	self diagramElement: OPNoShape new
]

{ #category : 'removing' }
OPUmlEnumerationLiteralController >> removeModel [
	"could be any of those, so just nil all of them"

	model enumeration: nil.
	super removeModel
]
