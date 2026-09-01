"
I am an edge label representing the primary name of a UML Association. I am typically positioned centrally along the association edge.
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
