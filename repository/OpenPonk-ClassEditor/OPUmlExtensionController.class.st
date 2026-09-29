"
I am the controller for UML Extensions. I manage the directed relationship between a Stereotype and a base UML Metaclass within a Profile diagram.
"
Class {
	#name : 'OPUmlExtensionController',
	#superclass : 'OPUmlAbstractAssociationController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPUmlExtensionController class >> diagramElementClass [

	^ OPUmlExtensionShape
]

{ #category : 'accessing' }
OPUmlExtensionController class >> viewModelClass [
	^ OPUmlExtensionViewModel
]
