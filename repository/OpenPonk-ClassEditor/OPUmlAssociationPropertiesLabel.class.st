Class {
	#name : #OPUmlAssociationPropertiesLabel,
	#superclass : #OPUmlEdgeLabel,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #'as yet unclassified' }
OPUmlAssociationPropertiesLabel >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintBalanceReference balance: 0.5
]

{ #category : #'as yet unclassified' }
OPUmlAssociationPropertiesLabel >> defaultMinDistance [

	^ 0
]

{ #category : #accessing }
OPUmlAssociationPropertiesLabel >> defaultText [

	^ (self owningElement propertiesOfModel: self modelElement)
		  ifEmpty: [ '' ]
		  ifNotEmpty: [ :props | '{' , (props joinUsing: ',') , '}' ]
]
