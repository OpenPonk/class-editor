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
	#category : 'OpenPonk-ClassEditor-Shapes'
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
	stereotypeLabel := OPUmlKeywordLabel new.
	stereotypeLabel text: [ :model | self stereotypeText ].
	stereotypeLabel localStyle: OPUmlStyle new.
	stereotypeLabel owningElement: self.
	nameLabel := OPUmlNameLabel new.
	nameLabel text: [ :model | model name ].
	nameLabel emphasis: [ :model :style | style fontItalic: model isAbstract ].
	nameLabel localStyle: (OPUmlStyle new fontSize: 11).
	nameLabel owningElement: self.
	attributes := OPUmlCompartment new.
	attributes owningElement: self.
	operations := OPUmlCompartment new.
	operations owningElement: self
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
	self hasStereotypes
		ifTrue: [ stereotypeLabel localStyle fontSize: 10 ]
		ifFalse: [ stereotypeLabel localStyle fontSize: 0 ].
	stereotypeLabel update.
	super update
]
