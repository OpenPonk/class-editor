Class {
	#name : #OPUmlAssociationEndLabel,
	#superclass : #OPUmlEdgeLabel,
	#instVars : [
		'atSource'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #accessing }
OPUmlAssociationEndLabel >> atSource [

	atSource := true
]

{ #category : #'as yet unclassified' }
OPUmlAssociationEndLabel >> defaultAnchorConstraintPosition [

	^ (atSource
		   ifTrue: [ OPRSAnchorConstraintStartPosition ]
		   ifFalse: [ OPRSAnchorConstraintEndPosition ]) distance: 10
]

{ #category : #accessing }
OPUmlAssociationEndLabel >> defaultText [

	^ self modelElement notationStringAsRoleName
]

{ #category : #initialization }
OPUmlAssociationEndLabel >> initialize [

	super initialize.
	atSource := false
]
