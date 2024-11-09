"
I am a controller for UML Extensions
"
Class {
	#name : 'OPUmlExtensionController',
	#superclass : 'OPUmlAbstractAssociationController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'figures' }
OPUmlExtensionController >> diagramElementClass [

	^ OPUmlExtensionShape
]

{ #category : 'accessing' }
OPUmlExtensionController >> modelClass [
	^ OPUMLExtension
]

{ #category : 'construction' }
OPUmlExtensionController >> modelSource: aModel in: aParentModel [

	| property |
	self modelSource = aModel ifTrue: [ ^ false ].
	(property := OPUMLExtensionEnd new)
		owningAssociation: self model;
		name: 'extension_' , aModel name;
		type: aModel.
	self model memberEnds add: property.
	self model ownedEnd: property.
	^ true
]

{ #category : 'construction' }
OPUmlExtensionController >> modelTarget: aModel in: aParentModel [

	| property |
	self modelTarget = aModel ifTrue: [ ^ false ].
	(property := OPUMLProperty new)
		owningClass: source model;
		name: 'base_' , aModel name;
		type: aModel.
	self model memberEnds add: property.
	^ true
]
