Class {
	#name : 'OPUmlAssociationPropertiesLabel',
	#superclass : 'OPUmlEdgeLabel',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'as yet unclassified' }
OPUmlAssociationPropertiesLabel >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintBalanceReference balance: 0.5
]

{ #category : 'accessing' }
OPUmlAssociationPropertiesLabel >> defaultText [

	^ (self owningElement propertiesOfModel: self modelElement)
		  ifEmpty: [ '' ]
		  ifNotEmpty: [ :props | '{' , (props joinUsing: ',') , '}' ]
]
