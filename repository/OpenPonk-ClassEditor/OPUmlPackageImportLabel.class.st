Class {
	#name : #OPUmlPackageImportLabel,
	#superclass : #OPUmlEdgeLabel,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #'as yet unclassified' }
OPUmlPackageImportLabel >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintBalanceReference balance: 0.5
]

{ #category : #'as yet unclassified' }
OPUmlPackageImportLabel >> defaultMinDistance [

	^ super defaultMinDistance negated
]

{ #category : #accessing }
OPUmlPackageImportLabel >> defaultText [

	^ '<<import>>'
]
