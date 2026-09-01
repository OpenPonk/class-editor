"
I am a specialized edge shape representing a UML Extension relationship, typically drawn between a Stereotype and a base metaclass. I customize the end markers (e.g., filled solid arrow) and disable certain standard association labels.
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
