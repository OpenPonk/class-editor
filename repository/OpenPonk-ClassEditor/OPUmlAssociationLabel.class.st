Class {
	#name : 'OPUmlAssociationLabel',
	#superclass : 'OPUmlEdgeLabel',
	#category : 'OpenPonk-ClassEditor-Shapes',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Shapes'
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
