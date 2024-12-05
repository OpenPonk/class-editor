Class {
	#name : 'OPUmlMultiplicityLabel',
	#superclass : 'OPUmlEdgeLabel',
	#instVars : [
		'atSource'
	],
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'ston-core' }
OPUmlMultiplicityLabel class >> stonAllInstVarNames [

	"Override to encode my instances using a custom set of instance variables or to define their order."

	^ super stonAllInstVarNames , #( #atSource )
]

{ #category : 'accessing' }
OPUmlMultiplicityLabel >> atSource [

	atSource := true
]

{ #category : 'as yet unclassified' }
OPUmlMultiplicityLabel >> defaultAnchorConstraintPosition [

	^ (atSource
		   ifTrue: [ OPRSAnchorConstraintStartDistanceReference ]
		   ifFalse: [ OPRSAnchorConstraintEndDistanceReference ]) distance: 10
]

{ #category : 'accessing' }
OPUmlMultiplicityLabel >> defaultText [

	^ self modelElement notationAssociationMultiplicityRange
]

{ #category : 'initialization' }
OPUmlMultiplicityLabel >> initialize [

	super initialize.
	atSource := false
]
