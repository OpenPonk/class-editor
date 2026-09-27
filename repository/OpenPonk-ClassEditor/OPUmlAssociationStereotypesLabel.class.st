"
An edge label that displays applied stereotypes along a UML association line.
"
Class {
	#name : 'OPUmlAssociationStereotypesLabel',
	#superclass : 'OPUmlEdgeLabel',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'adding' }
OPUmlAssociationStereotypesLabel >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintBalanceReference balance: 0.5
]

{ #category : 'adding' }
OPUmlAssociationStereotypesLabel >> defaultMinDistance [

	^ 0
]

{ #category : 'accessing' }
OPUmlAssociationStereotypesLabel >> defaultText [

	^ self modelElement appliedStereotypes
		  ifEmpty: [ '' ]
		  ifNotEmpty: [ :s | 
		  '«' , ((s collect: #umlClassName) joinUsing: ',') , '»' ]
]
