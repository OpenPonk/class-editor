Class {
	#name : #OPUmlClassifierShape,
	#superclass : #OPUmlCompartmentableShape,
	#instVars : [
		'commentIcon'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #rendering }
OPUmlClassifierShape >> hasModelComments [

	| ownedComments |
	ownedComments := self modelElement ownedComments.
	^ ownedComments isNotNil and: [ 
		  ownedComments anySatisfy: [ :any | 
			  any body isNotNil and: [ any body isNotEmpty ] ] ]
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

	self updateCommentIcon.

	super updateRenderFromModel
]
