"
An edge label representing the primary name of a UML association, positioned along the center of the association line.
"
Class {
	#name : 'OPUmlAssociationLabel',
	#superclass : 'OPUmlEdgeLabel',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'adding' }
OPUmlAssociationLabel >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintBalanceReference balance: 0.5
]

{ #category : 'accessing' }
OPUmlAssociationLabel >> defaultText [

	^ (self modelElement isDerived
		   ifTrue: [ '/' ]
		   ifFalse: [ '' ]) , (self modelElement name ifNil: [ '' ])
]
