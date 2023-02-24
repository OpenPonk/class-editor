Class {
	#name : #OPUmlAssociationLabel,
	#superclass : #OPUmlEdgeLabel,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #'as yet unclassified' }
OPUmlAssociationLabel >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintBalanceReference balance: 0.5
]

{ #category : #'as yet unclassified' }
OPUmlAssociationLabel >> defaultMinDistance [

	^ super defaultMinDistance negated
]

{ #category : #accessing }
OPUmlAssociationLabel >> defaultText [

	^ (self modelElement isDerived
		   ifTrue: [ '/' ]
		   ifFalse: [ '' ]) , (self modelElement name ifNil: [ '' ])
]
