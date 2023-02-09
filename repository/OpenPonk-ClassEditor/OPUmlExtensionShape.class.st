"
I represent an Extension shape
"
Class {
	#name : #OPUmlExtensionShape,
	#superclass : #OPUmlAssociationShape,
	#instVars : [
		'isRequiredLabel'
	],
	#category : #'OpenPonk-ClassEditor-Shapes'
}

{ #category : #accessing }
OPUmlExtensionShape >> endLabelsClass [
	^ OPUmlExtensionEndLabels
]

{ #category : #initialization }
OPUmlExtensionShape >> initialize [
	super initialize.
	(isRequiredLabel := OPUmlAssociationEndLabel new)
		text: [ :model | 
			model isRequired
				ifTrue: [ '{required}' ]
				ifFalse: [ '' ] ];
		owningElement: self
]

{ #category : #accessing }
OPUmlExtensionShape >> markerFor: aProperty [
	(aProperty name beginsWith: 'base_')
		ifTrue: [ ^ OPUmlEdgeMarkers filledArrow ].
	^ OPUmlEdgeMarkers none
]

{ #category : #accessing }
OPUmlExtensionShape >> modelElement: aModel [
	super modelElement: aModel.
	isRequiredLabel modelElement: aModel
]

{ #category : #rendering }
OPUmlExtensionShape >> renderIn: aView [
	super renderIn: aView.
	constraints
		add: (self constraintLabel: isRequiredLabel at: #target side: -1)
]
