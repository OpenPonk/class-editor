Class {
	#name : #OPUmlPackageImportLabel,
	#superclass : #OPUmlEdgeLabel,
	#category : #'OpenPonk-ClassEditor-Shapes'
}

{ #category : #'as yet unclassified' }
OPUmlPackageImportLabel >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintBalanceReference balance: 0.5
]

{ #category : #accessing }
OPUmlPackageImportLabel >> defaultText [

	^ '<<import>>'
]
