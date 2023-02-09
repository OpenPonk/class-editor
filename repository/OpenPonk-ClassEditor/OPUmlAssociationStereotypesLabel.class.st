Class {
	#name : #OPUmlAssociationStereotypesLabel,
	#superclass : #OPUmlEdgeLabel,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #'as yet unclassified' }
OPUmlAssociationStereotypesLabel >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintBalancePosition balance: 0.5
]

{ #category : #accessing }
OPUmlAssociationStereotypesLabel >> defaultText [

	^ self modelElement appliedStereotypes
		  ifEmpty: [ '' ]
		  ifNotEmpty: [ :s | 
		  '«' , ((s collect: #umlClassName) joinUsing: ',') , '»' ]
]
