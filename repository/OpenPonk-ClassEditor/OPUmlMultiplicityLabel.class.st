Class {
	#name : #OPUmlMultiplicityLabel,
	#superclass : #OPUmlEdgeLabel,
	#instVars : [
		'atSource'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #accessing }
OPUmlMultiplicityLabel >> atSource [

	atSource := true
]

{ #category : #'as yet unclassified' }
OPUmlMultiplicityLabel >> defaultAnchorConstraintPosition [

	^ (atSource
		   ifTrue: [ OPRSAnchorConstraintStartPosition ]
		   ifFalse: [ OPRSAnchorConstraintEndPosition ]) distance: 10
]

{ #category : #'as yet unclassified' }
OPUmlMultiplicityLabel >> defaultMinDistance [

	^ super defaultMinDistance negated
]

{ #category : #accessing }
OPUmlMultiplicityLabel >> defaultText [

	^ self modelElement notationAssociationMultiplicityRange
]
