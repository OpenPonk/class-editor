"
An edge shape representing a UML PackageImport, rendering a dashed line connecting an importing namespace to an imported package.
"
Class {
	#name : 'OPUmlPackageImportShape',
	#superclass : 'OPUmlEdge',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'Roassal2 - accessing' }
OPUmlPackageImportShape >> headMarker [

	^ OPRSMarkerBuilder arrow
]

{ #category : 'initialization' }
OPUmlPackageImportShape >> initialize [

	super initialize.
	OPUmlPackageImportLabel in: self forModelElement: self modelElement
]
