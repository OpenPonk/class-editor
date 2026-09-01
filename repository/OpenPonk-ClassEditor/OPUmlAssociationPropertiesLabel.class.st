"
I am an edge label used to display specific property constraints on a UML Association end, such as `{ordered}` or `{readOnly}`.
"
Class {
	#name : 'OPUmlAssociationPropertiesLabel',
	#superclass : 'OPUmlEdgeLabel',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'adding' }
OPUmlAssociationPropertiesLabel >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintBalanceReference balance: 0.5
]

{ #category : 'accessing' }
OPUmlAssociationPropertiesLabel >> defaultText [

	^ (self owningElement propertiesOfModel: self modelElement)
		  ifEmpty: [ '' ]
		  ifNotEmpty: [ :props | '{' , (props joinUsing: ',') , '}' ]
]
