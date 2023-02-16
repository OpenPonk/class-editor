"
I represent an Extension shape
"
Class {
	#name : #OPUmlExtensionShape,
	#superclass : #OPUmlAssociationShape,
	#instVars : [
		'isRequiredLabel'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

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
		ifTrue: [ ^ OPRSMarkerBuilder triangle ].
	^ nil
]

{ #category : #accessing }
OPUmlExtensionShape >> modelElement: aModel [
	super modelElement: aModel.
	isRequiredLabel modelElement: aModel
]
