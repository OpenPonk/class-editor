"
I represent an Extension shape
"
Class {
	#name : 'OPUmlExtensionShape',
	#superclass : 'OPUmlAssociationShape',
	#category : 'OpenPonk-ClassEditor-Shapes',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Shapes'
}

{ #category : 'initialization' }
OPUmlExtensionShape >> createEndLabels [

	OPUmlExtensionRequiredLabel in: self
]

{ #category : 'accessing' }
OPUmlExtensionShape >> markerShapeFor: aProperty [
	(aProperty name beginsWith: 'base_')
		ifTrue: [ ^ OPRSMarkerBuilder triangle ].
	^ nil
]
