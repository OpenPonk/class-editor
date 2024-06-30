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

	^ model memberEnds ifNotEmpty: [ :memberEnds | memberEnds first type ]
]

{ #category : 'construction' }
OPUmlExtensionController >> modelSource: aModel in: aParentModel [

	| property |
	self modelSource = aModel ifTrue: [ ^ false ].
	(property := OPUMLExtensionEnd new)
		owningAssociation: model;
		name: 'extension_' , aModel name;
		type: aModel.
	model memberEnds add: property.
	model ownedEnd: property.
	^ true
]

{ #category : 'accessing' }
OPUmlExtensionController >> modelTarget [

	^ model memberEnds size > 1
		  ifTrue: [ model memberEnds second type ]
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
	model memberEnds add: property.
	^ true
]

{ #category : 'removing' }
OPUmlExtensionController >> removeModel [
	"extra work to trigger update of the end classes... maybe this should be automatic for edges"

	self diagramController model packagedElements remove: self model.
	[ self model memberEnds isNotEmpty ]
		whileTrue: [ | end |
			end := self model memberEnds first.
			end association: nil.
			end owningClass: nil.
			end owningAssociation: nil ]
]
