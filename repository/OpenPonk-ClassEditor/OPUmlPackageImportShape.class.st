"
I represent a import line from importing to imported package.
"
Class {
	#name : 'OPUmlPackageImportShape',
	#superclass : 'OPUmlEdge',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'hooks' }
OPUmlPackageImportShape >> headMarker [

	^ OPRSMarkerBuilder arrow
]

{ #category : 'initialization' }
OPUmlPackageImportShape >> initialize [

	super initialize.
	OPUmlPackageImportLabel in: self forModelElement: self modelElement
]
