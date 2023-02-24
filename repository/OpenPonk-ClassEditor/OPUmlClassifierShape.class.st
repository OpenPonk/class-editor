Class {
	#name : #OPUmlClassifierShape,
	#superclass : #OPUmlCompartmentableShape,
	#instVars : [
		'nameLabel',
		'stereotypeLabel',
		'commentIcon'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #'ston-core' }
OPUmlClassifierShape class >> stonAllInstVarNames [

	"Override to encode my instances using a custom set of instance variables or to define their order."

	^ super stonAllInstVarNames , #( #nameLabel #stereotypeLabel #commentIcon )
]

{ #category : #accessing }
OPUmlClassifierShape >> color [

	^ self stylePropertyNamed: #fillColor ifAbsent: [ Color transparent ]
]

{ #category : #accessing }
OPUmlClassifierShape >> color: aColor [

	^ self stylePropertyNamed: #fillColor put: aColor
]

{ #category : #initialization }
OPUmlClassifierShape >> createLabel: aLabelShapeClass [

	| labelContainer |
	labelContainer := OPUmlCompartmentableLabel in: self.
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
OPUmlClassifierShape >> createOwnedElementsWithoutController [

	super createOwnedElementsWithoutController.
	self createLabel: OPUmlClassifierNameLabel
]

{ #category : #rendering }
OPUmlClassifierShape >> hasModelComments [

	| ownedComments |
	ownedComments := self modelElement ownedComments.
	^ ownedComments isNotNil and: [ 
		  ownedComments anySatisfy: [ :any | 
			  any body isNotNil and: [ any body isNotEmpty ] ] ]
]

{ #category : #accessing }
OPUmlClassifierShape >> minExtent [

	^ 100 @ 60
]

{ #category : #accessing }
OPUmlClassifierShape >> stereotypes [

	^ self stereotypesLabelClass new
		  modelElement: self modelElement;
		  stereotypeNames
]

{ #category : #rendering }
OPUmlClassifierShape >> stereotypesLabelClass [

	^ self subclassResponsibility
]

{ #category : #rendering }
OPUmlClassifierShape >> updateCommentIcon [

	self hasModelComments ifFalse: [ 
		commentIcon ifNotNil: [ 
			commentIcon remove.
			commentIcon := nil ].
		^ self ].

	commentIcon ifNotNil: [ ^ self ].

	commentIcon := OPUmlCommentIcon
		               in: self
		               forModelElement: self modelElement.

	self isRendered ifTrue: [ commentIcon renderIn: self canvas ]
]

{ #category : #rendering }
OPUmlClassifierShape >> updateRenderFromModel [

	self updateStereotype.

	self compartments do: #sortOwnedElements.

	self updateCommentIcon.

	super updateRenderFromModel
]

{ #category : #rendering }
OPUmlClassifierShape >> updateRenderFromSelf [

	self isRendered ifFalse: [ ^ self ].
	roassalShape color: self color.
	super updateRenderFromSelf
]

{ #category : #rendering }
OPUmlClassifierShape >> updateStereotype [

	self stereotypes ifEmpty: [ 
		stereotypeLabel ifNotNil: [ 
			stereotypeLabel remove.
			stereotypeLabel := nil ].
		^ self ].

	stereotypeLabel ifNotNil: [ ^ self ].

	stereotypeLabel := self createLabel: self stereotypesLabelClass.

	self isRendered ifTrue: [ stereotypeLabel renderIn: self canvas ]
]
