Class {
	#name : #OPUmlAssociationEndLabel,
	#superclass : #OPUmlEdgeLabel,
	#instVars : [
		'atSource'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #'ston-core' }
OPUmlAssociationEndLabel class >> stonAllInstVarNames [

	"Override to encode my instances using a custom set of instance variables or to define their order."

	^ super stonAllInstVarNames , #( #atSource )
]

{ #category : #accessing }
OPUmlAssociationEndLabel >> atSource [

	atSource := true
]

{ #category : #'as yet unclassified' }
OPUmlAssociationEndLabel >> defaultAnchorConstraintPosition [

	^ (atSource
		   ifTrue: [ OPRSAnchorConstraintStartDistanceReference ]
		   ifFalse: [ OPRSAnchorConstraintEndDistanceReference ]) distance: 10
]

{ #category : #'as yet unclassified' }
OPUmlAssociationEndLabel >> defaultMinDistance [

	^ super defaultMinDistance negated
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
