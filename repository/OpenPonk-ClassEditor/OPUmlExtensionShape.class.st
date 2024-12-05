"
I represent an Extension shape
"
Class {
	#name : 'OPUmlExtensionShape',
	#superclass : 'OPUmlAssociationShape',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
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
