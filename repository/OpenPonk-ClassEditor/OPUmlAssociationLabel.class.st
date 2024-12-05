Class {
	#name : 'OPUmlAssociationLabel',
	#superclass : 'OPUmlEdgeLabel',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'as yet unclassified' }
OPUmlAssociationLabel >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintBalanceReference balance: 0.5
]

{ #category : 'accessing' }
OPUmlAssociationLabel >> defaultText [

	^ (self modelElement isDerived
		   ifTrue: [ '/' ]
		   ifFalse: [ '' ]) , (self modelElement name ifNil: [ '' ])
]
