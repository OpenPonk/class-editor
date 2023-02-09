"
I am a collection of labels for association's memberEnd.
"
Class {
	#name : #OPUmlAssociationEndLabels,
	#superclass : #Object,
	#instVars : [
		'nameLabel',
		'multiplicityLabel',
		'redefinesLabel',
		'modifiersLabel',
		'associationShape',
		'modelElement'
	],
	#category : #'OpenPonk-ClassEditor-Shapes'
}

{ #category : #'instance creation' }
OPUmlAssociationEndLabels class >> on: anAssociationShape [
	^ self basicNew
		initializeOn: anAssociationShape;
		yourself
]

{ #category : #adding }
OPUmlAssociationEndLabels >> addConstraintsTo: aCollection at: aPosition [
	aCollection
		add: (self constraintLabel: nameLabel at: aPosition side: 1);
		add: (self constraintLabel: multiplicityLabel at: aPosition side: -1)
]

{ #category : #configuration }
OPUmlAssociationEndLabels >> constraintLabel: aLabel at: aPosition side: aSide [
	| config anchor |
	config := Dictionary
		with: #source -> (Array with: 10 with: aSide * 10)
		with: #target -> (Array with: -10 with: aSide * 10)
		with: #middle -> (Array with: 0.5 with: 10).
	anchor := OPRTAnchorConstraint new.
	anchor
		element: aLabel rtElement;
		edge: associationShape rtEdge;
		balance: (config at: aPosition) first;
		minDistance: (config at: aPosition) second.
	^ anchor
]

{ #category : #initialization }
OPUmlAssociationEndLabels >> initializeOn: anAssociationShape [

	self initialize.
	associationShape := anAssociationShape.
	nameLabel := OPUmlAssociationEndLabel
		             in: anAssociationShape
		             forModelElement: modelElement.
	(multiplicityLabel := OPUmlMultiplicityLabel new)
		text: [ :model | model notationAssociationMultiplicityRange ];
		owningElement: anAssociationShape
]

{ #category : #accessing }
OPUmlAssociationEndLabels >> modelElement [
	^ modelElement
]

{ #category : #accessing }
OPUmlAssociationEndLabels >> modelElement: anObject [
	modelElement := anObject.
	nameLabel modelElement: anObject.
	multiplicityLabel modelElement: anObject
]
