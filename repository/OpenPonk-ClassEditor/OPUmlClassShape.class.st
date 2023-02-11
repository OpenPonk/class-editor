"
I am a classifier shape composition to accomodate for the most common UML Class Diagram shape.
"
Class {
	#name : #OPUmlClassShape,
	#superclass : #OPUmlClassifierShape,
	#instVars : [
		'nameLabel',
		'attributes',
		'operations',
		'stereotypeLabel',
		'stereotypeBlock'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #accessing }
OPUmlClassShape >> attributes [
	^ attributes
]

{ #category : #accessing }
OPUmlClassShape >> hasStereotypes [
	^ stereotypeBlock value isNotEmpty
]

{ #category : #initialization }
OPUmlClassShape >> initialize [

	super initialize.
	self sharedStyle fillColor: Color white.
	stereotypeLabel := OPUmlKeywordLabel
		                   in: self
		                   forModelElement: self modelElement.
	nameLabel := OPUmlClassifierNameLabel
		             in: self
		             forModelElement: self modelElement.
	attributes := OPUmlCompartment
		              in: self
		              forModelElement: self modelElement.
	operations := OPUmlCompartment
		              in: self
		              forModelElement: self modelElement
]

{ #category : #accessing }
OPUmlClassShape >> modelElement: aModelElement [
	super modelElement: aModelElement.
	nameLabel modelElement: aModelElement
]

{ #category : #accessing }
OPUmlClassShape >> operations [
	^ operations
]

{ #category : #accessing }
OPUmlClassShape >> stereotype: aStereotypeBlock [
	stereotypeBlock := aStereotypeBlock
]

{ #category : #accessing }
OPUmlClassShape >> stereotypeText [
	^ stereotypeBlock value
		ifEmpty: [ '' ]
		ifNotEmpty: [ :vals | '«' , (vals joinUsing: ', ') , '»' ]
]

{ #category : #'Roassal2 - updating' }
OPUmlClassShape >> update [
	stereotypeLabel localStyle
		fontSize:
			(self hasStereotypes
				ifTrue: [ 10 ]
				ifFalse: [ 0 ]).
	stereotypeLabel update.
	super update
]
