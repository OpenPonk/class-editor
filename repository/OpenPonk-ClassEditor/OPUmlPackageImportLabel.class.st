"
I am an edge label for UML PackageImports. I render the required keyword, typically `<<import>>` or `<<access>>`, along the dashed import edge.
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
