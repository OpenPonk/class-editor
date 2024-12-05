Class {
	#name : 'OPUmlAssociationStereotypesLabel',
	#superclass : 'OPUmlEdgeLabel',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'as yet unclassified' }
OPUmlAssociationStereotypesLabel >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintBalanceReference balance: 0.5
]

{ #category : 'as yet unclassified' }
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
