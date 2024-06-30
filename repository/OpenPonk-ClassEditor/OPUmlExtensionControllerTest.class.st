Class {
	#name : 'OPUmlExtensionControllerTest',
	#superclass : 'OPUmlRelationshipControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'accessing' }
OPUmlExtensionControllerTest >> controllerClass [
	^ OPUmlExtensionController
]

{ #category : 'construction' }
OPUmlExtensionControllerTest >> diagramElementClass [

	^ OPUmlExtensionShape
]

{ #category : 'running' }
OPUmlExtensionControllerTest >> diagramModelClass [

	^ OPUMLProfile
]

{ #category : 'accessing' }
OPUmlExtensionControllerTest >> modelClass [
	^ OPUMLExtension
]

{ #category : 'as yet unclassified' }
OPUmlExtensionControllerTest >> sourceControllerClass [

	^ OPUmlStereotypeController
]

{ #category : 'as yet unclassified' }
OPUmlExtensionControllerTest >> sourceModelClass [

	^ OPUMLStereotype
]

{ #category : 'as yet unclassified' }
OPUmlExtensionControllerTest >> targetControllerClass [

	^ OPUmlClassController
]

{ #category : 'as yet unclassified' }
OPUmlExtensionControllerTest >> targetModelClass [

	^ OPUMLClass
]
