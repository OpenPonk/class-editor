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

{ #category : #rendering }
OPUmlClassShape >> addAttribute: anAttributeShape [

	attributes ifNil: [ 
		attributes := OPUmlListCompartment
			              in: self
			              forModelElement: self modelElement.
		operations ifNotNil: [ 
			self ownedElements: (self ownedElements sorted: [ :a :b | 
					 (a = attributes and: [ b = operations ]) or: [ 
						 (a ~= operations or: [ b ~= attributes ]) and: [ 
							 (self ownedElements indexOf: a)
							 < (self ownedElements indexOf: b) ] ] ]) ] ].

	anAttributeShape owningElement: attributes
]

{ #category : #rendering }
OPUmlClassShape >> addOperation: anOperationShape [

	operations ifNil: [ 
		operations := OPUmlFeaturesListCompartment
			              in: self
			              forModelElement: self modelElement ].

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

	attributes ownedElements ifEmpty: [ 
		attributes remove.
		attributes := nil ].

	self isRendered ifTrue: [ self updateRenderFromModel ]
]

{ #category : #rendering }
OPUmlClassShape >> removeOperation: anOperationShape [

	anOperationShape remove.

	operations ownedElements ifEmpty: [ 
		operations remove.
		operations := nil ].

	self isRendered ifTrue: [ self updateRenderFromModel ]
]

{ #category : #rendering }
OPUmlClassShape >> stereotypesLabelClass [

	^ OPUmlAppliedStereotypesLabel
]
