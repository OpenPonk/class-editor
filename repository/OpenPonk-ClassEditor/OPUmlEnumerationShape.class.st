Class {
	#name : #OPUmlEnumerationShape,
	#superclass : #OPUmlClassifierShape,
	#instVars : [
		'literals'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #adding }
OPUmlEnumerationShape >> addLiteral: aLiteralShape [

	literals ifNil: [ 
		literals := OPUmlListCompartment
			            in: self
			            forModelElement: self modelElement ].

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
