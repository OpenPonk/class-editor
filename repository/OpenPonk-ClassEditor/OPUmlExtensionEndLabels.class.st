Class {
	#name : #OPUmlExtensionEndLabels,
	#superclass : #OPUmlAssociationEndLabels,
	#category : 'OpenPonk-ClassEditor-Shapes'
}

{ #category : #'instance creation' }
OPUmlExtensionEndLabels class >> on: anAssociationShape [
	^ self basicNew
		initializeOn: anAssociationShape;
		yourself
]

{ #category : #adding }
OPUmlExtensionEndLabels >> addConstraintsTo: aCollection at: aPosition [
	aCollection
		add: (self constraintLabel: nameLabel at: aPosition side: 1);
		add: (self constraintLabel: multiplicityLabel at: aPosition side: -1)
]

{ #category : #configuration }
OPUmlExtensionEndLabels >> constraintLabel: aLabel at: aPosition side: aSide [
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
OPUmlExtensionEndLabels >> initializeOn: anAssociationShape [
	self initialize.
	associationShape := anAssociationShape.
	(nameLabel := OPUmlAssociationEndLabel new)
		text: [ :model | '' ];
		owningElement: anAssociationShape.
	(multiplicityLabel := OPUmlMultiplicityLabel new)
		text: [ :model | '' ];
		owningElement: anAssociationShape
]

{ #category : #accessing }
OPUmlExtensionEndLabels >> modelElement [
	^ modelElement
]

{ #category : #accessing }
OPUmlExtensionEndLabels >> modelElement: anObject [
	modelElement := anObject.
	nameLabel modelElement: anObject.
	multiplicityLabel modelElement: anObject
]
