"
An edge shape representing a UML Extension between a Stereotype and a metaclass, customizing arrowheads and label visibility.
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
