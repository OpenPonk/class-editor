Class {
	#name : #OPUmlEnumerationShape,
	#superclass : #OPUmlClassifierShape,
	#instVars : [
		'literals'
	],
	#category : #'OpenPonk-ClassEditor-Shapes'
}

{ #category : #'ston-core' }
OPUmlEnumerationShape class >> stonAllInstVarNames [

	"Override to encode my instances using a custom set of instance variables or to define their order."

	^ super stonAllInstVarNames , #( #literals )
]

{ #category : #adding }
OPUmlEnumerationShape >> addLiteral: aLiteralShape [

	literals ifNil: [ literals := OPUmlListCompartment in: self ].

	aLiteralShape owningElement: literals
]

{ #category : #accessing }
OPUmlEnumerationShape >> literals [
	^ literals
]

{ #category : #removing }
OPUmlEnumerationShape >> removeLiteral: aLiteralShape [

	aLiteralShape remove.

	literals ownedElements ifEmpty: [ 
		literals remove.
		literals := nil ].

	self isRendered ifTrue: [ self updateRenderFromModel ]
]

{ #category : #rendering }
OPUmlEnumerationShape >> stereotypesLabelClass [

	^ OPUmlEnumerationStereotypeLabel
]
