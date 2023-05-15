"
I am a classifier shape composition to accomodate for the most common UML Class Diagram shape.
"
Class {
	#name : #OPUmlClassShape,
	#superclass : #OPUmlClassifierShape,
	#instVars : [
		'attributes',
		'operations'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #'ston-core' }
OPUmlClassShape class >> stonAllInstVarNames [

	"Override to encode my instances using a custom set of instance variables or to define their order."

	^ super stonAllInstVarNames , #( #attributes #operations )
]

{ #category : #rendering }
OPUmlClassShape >> addAttribute: anAttributeShape [

	attributes ifNil: [ 
		attributes := OPUmlListCompartment in: self.

		self sortOwnedElements ].

	anAttributeShape owningElement: attributes
]

{ #category : #rendering }
OPUmlClassShape >> addOperation: anOperationShape [

	operations ifNil: [ 
		operations := OPUmlFeaturesListCompartment in: self.

		self sortOwnedElements ].

	anOperationShape owningElement: operations
]

{ #category : #accessing }
OPUmlClassShape >> attributes [
	^ attributes
]

{ #category : #accessing }
OPUmlClassShape >> operations [
	^ operations
]

{ #category : #rendering }
OPUmlClassShape >> removeAttribute: anAttributeShape [

	anAttributeShape remove.

	attributes ifNotNil: [ :compartment |
		compartment ownedElements ifEmpty: [
			attributes remove.
			attributes := nil ] ].

	self isRendered ifTrue: [ self updateRenderFromModel ]
]

{ #category : #rendering }
OPUmlClassShape >> removeOperation: anOperationShape [

	anOperationShape remove.

	operations ifNotNil: [ :compartment |
		compartment ownedElements ifEmpty: [
			operations remove.
			operations := nil ] ].

	self isRendered ifTrue: [ self updateRenderFromModel ]
]

{ #category : #sorting }
OPUmlClassShape >> sortOwnedElements [

	| properOrder |
	properOrder := (self ownedElements select: [ :each | 
		                each isKindOf: OPUmlCompartmentableLabel ]) , { 
		               attributes.
		               operations.
		               commentIcon } reject: #isNil.
	self assert:
		self ownedElements asIdentitySet = properOrder asIdentitySet.
	self ownedElements: properOrder
]

{ #category : #rendering }
OPUmlClassShape >> stereotypesLabelClass [

	^ OPUmlAppliedStereotypesLabel
]
