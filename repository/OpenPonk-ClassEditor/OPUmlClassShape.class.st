"
I am a classifier shape composition to accomodate for the most common UML Class Diagram shape.
"
Class {
	#name : #OPUmlClassShape,
	#superclass : #OPUmlClassifierShape,
	#instVars : [
		'nameLabel',
		'stereotypeLabel',
		'attributes',
		'operations'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #rendering }
OPUmlClassShape >> addAttribute: anAttributeShape [

	attributes ifNil: [ 
		attributes := self createCompartment.
		operations ifNotNil: [ 
			self ownedElements: (self ownedElements sorted: [ :a :b | 
					 (a = attributes and: [ b = operations ]) or: [ 
						 (a ~= operations or: [ b ~= attributes ]) and: [ 
							 (self ownedElements indexOf: a)
							 < (self ownedElements indexOf: b) ] ] ]) ] ].

	anAttributeShape owningElement: attributes.
	
	self isRendered ifTrue: [ attributes renderIn: self canvas ].

	attributes sortOwnedElements
]

{ #category : #rendering }
OPUmlClassShape >> addOperation: anOperationShape [

	operations ifNil: [ operations := self createCompartment ].

	anOperationShape owningElement: operations.
	
	self isRendered ifTrue: [ operations renderIn: self canvas ].

	operations sortOwnedElements
]

{ #category : #accessing }
OPUmlClassShape >> attributes [
	^ attributes
]

{ #category : #initialization }
OPUmlClassShape >> createCompartment [

	^ OPUmlCompartment in: self forModelElement: self modelElement
]

{ #category : #initialization }
OPUmlClassShape >> createLabel: aLabelShapeClass [

	| labelContainer |
	labelContainer := OPUmlCompartmentableLabel
		                  in: self
		                  forModelElement: self modelElement.
	aLabelShapeClass
		in: labelContainer
		forModelElement: self modelElement.
	self ownedElements: (self ownedElements sorted: [ :a :b | 
			 a = labelContainer or: [ 
				 b ~= labelContainer and: [ 
					 (self ownedElements indexOf: a)
					 < (self ownedElements indexOf: b) ] ] ]).
	^ labelContainer
]

{ #category : #initialization }
OPUmlClassShape >> createOwnedElementsWithoutController [

	super createOwnedElementsWithoutController.
	self createLabel: OPUmlClassifierNameLabel
]

{ #category : #initialization }
OPUmlClassShape >> initialize [

	super initialize.
	separators := OrderedCollection new
]

{ #category : #accessing }
OPUmlClassShape >> operations [
	^ operations
]

{ #category : #rendering }
OPUmlClassShape >> removeAttribute: anAttributeShape [

	anAttributeShape remove.

	attributes remove.
	attributes := nil
]

{ #category : #rendering }
OPUmlClassShape >> removeOperation: anOperationShape [

	anOperationShape remove.

	operations remove.
	operations := nil
]

{ #category : #rendering }
OPUmlClassShape >> updateRenderFromModel [

	self updateStereotype.

	super updateRenderFromModel
]

{ #category : #rendering }
OPUmlClassShape >> updateStereotype [

	self modelElement appliedStereotypes ifEmpty: [ 
		stereotypeLabel ifNotNil: [ 
			stereotypeLabel remove.
			stereotypeLabel := nil ].
		^ self ].

	stereotypeLabel ifNotNil: [ ^ self ].

	stereotypeLabel := self createLabel: OPUmlStereotypeLabel.

	self isRendered ifTrue: [ stereotypeLabel renderIn: self canvas ]
]
