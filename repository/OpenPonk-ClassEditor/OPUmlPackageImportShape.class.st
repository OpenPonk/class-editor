"
I represent a import line from importing to imported package.
"
Class {
	#name : #OPUmlPackageImportShape,
	#superclass : #OPUmlEdge,
	#instVars : [
		'nameLabel',
		'constraints'
	],
	#category : #'OpenPonk-ClassEditor-Shapes'
}

{ #category : #hooks }
OPUmlPackageImportShape >> headMarker [

	^ OPRSMarkerBuilder arrow
]

{ #category : #initialization }
OPUmlPackageImportShape >> initialize [

	super initialize.
	nameLabel := OPUmlPackageImportLabel
		             in: self
		             forModelElement: self modelElement.
	constraints := OrderedCollection new
]
