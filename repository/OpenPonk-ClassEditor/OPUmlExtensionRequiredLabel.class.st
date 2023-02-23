Class {
	#name : #OPUmlExtensionRequiredLabel,
	#superclass : #OPUmlEdgeLabel,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #'as yet unclassified' }
OPUmlExtensionRequiredLabel >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintEndPosition distance: 10
]

{ #category : #accessing }
OPUmlExtensionRequiredLabel >> defaultText [

	^ self modelElement isRequired
		  ifTrue: [ '{required}' ]
		  ifFalse: [ '' ]
]
