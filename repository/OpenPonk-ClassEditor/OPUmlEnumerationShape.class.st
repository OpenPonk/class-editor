"
A diagram shape representing a UML Enumeration, composing a bounding box and a dedicated compartment for enumeration literals.
"
Class {
	#name : 'OPUmlEnumerationShape',
	#superclass : 'OPUmlClassifierShape',
	#instVars : [
		'literalsCompartment'
	],
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'ston-core' }
OPUmlEnumerationShape class >> stonAllInstVarNames [
	^ super stonAllInstVarNames , #( #literalsCompartment )
]

{ #category : 'adding' }
OPUmlEnumerationShape >> addLiteral: aLiteralShape [
	literalsCompartment ifNil: [ literalsCompartment := OPUmlListCompartment in: self ].
	aLiteralShape owningElement: literalsCompartment
]

{ #category : 'accessing' }
OPUmlEnumerationShape >> literalsCompartment [
	^ literalsCompartment
]

{ #category : 'removing' }
OPUmlEnumerationShape >> removeLiteral: aLiteralShape [
	aLiteralShape remove.
	literalsCompartment ownedElements ifEmpty: [
		literalsCompartment remove.
		literalsCompartment := nil ].
	self isRendered ifTrue: [ self updateRenderFromModel ]
]

{ #category : 'rendering' }
OPUmlEnumerationShape >> stereotypesLabelClass [

	^ OPUmlEnumerationStereotypeLabel
]

{ #category : 'ston-core' }
OPUmlEnumerationShape >> stonInstVarNameFor: anInstVarName [
	anInstVarName = #literals ifTrue: [ ^ #literalsCompartment ].
	^ super stonInstVarNameFor: anInstVarName
]
