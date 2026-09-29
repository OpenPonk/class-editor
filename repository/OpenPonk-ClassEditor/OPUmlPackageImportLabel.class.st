"
An edge label for UML package imports rendering keywords such as <<import>> or <<access>> along the dashed import line.
"
Class {
	#name : 'OPUmlPackageImportLabel',
	#superclass : 'OPUmlEdgeLabel',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'adding' }
OPUmlPackageImportLabel >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintBalanceReference balance: 0.5
]

{ #category : 'accessing' }
OPUmlPackageImportLabel >> defaultText [

	^ '<<import>>'
]
