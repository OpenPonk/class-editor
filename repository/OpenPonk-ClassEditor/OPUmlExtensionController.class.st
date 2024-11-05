"
I am a controller for UML Extensions
"
Class {
	#name : 'OPUmlExtensionController',
	#superclass : 'OPUmlRelationshipController',
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

{ #category : 'accessing' }
OPUmlExtensionController >> modelSource [

	^ self model memberEnds ifNotEmpty: [ :memberEnds |
		  memberEnds first type ]
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

{ #category : 'accessing' }
OPUmlExtensionController >> modelTarget [

	^ self model memberEnds size > 1
		  ifTrue: [ self model memberEnds second type ]
		  ifFalse: [ nil ]
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

{ #category : 'removing' }
OPUmlExtensionController >> removeModel [
	"extra work to trigger update of the end classes... maybe this should be automatic for edges"

	[ self model memberEnds isNotEmpty ] whileTrue: [
		| end |
		end := self model memberEnds first.
		end association: nil.
		end owningClass: nil.
		end owningAssociation: nil ].
	super removeModel
]
