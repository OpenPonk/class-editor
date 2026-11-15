"
I am a unit test class verifying the behavior of OPUmlPackageDiagramController, explicitly testing the correct canvas rendering of UML classes and their inner attributes.
"
Class {
	#name : 'OPUmlPackageDiagramControllerTest',
	#superclass : 'OPAbstractDiagramControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests-Controllers',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPUmlPackageDiagramControllerTest class >> diagramElementClass [

	^ OPOpenPonkDiagram
]

{ #category : 'constants' }
OPUmlPackageDiagramControllerTest >> controllerClass [
	^ OPUmlPackageDiagramController
]

{ #category : 'construction' }
OPUmlPackageDiagramControllerTest >> diagramElementClass [
	^ self class diagramElementClass
]

{ #category : 'constants' }
OPUmlPackageDiagramControllerTest >> modelClass [
	^ OPUMLPackage
]

{ #category : 'tests' }
OPUmlPackageDiagramControllerTest >> testShowClassInDiagram [

	| class renderedModels |
	class := OPUMLClass new.
	controller showWithoutDependentInDiagramModel: class.
	renderedModels := controller canvas nodes
		                  select: [ :each | each model isNotNil ]
		                  thenCollect: [ :each | each model modelElement ].
	self assertCollection: renderedModels includesAll: { class }.
	self assert: (controller hasControllerForModel: class) description: 'Diagram controller must register class controller'
]

{ #category : 'tests' }
OPUmlPackageDiagramControllerTest >> testShowClassWithAttributeInDiagram [

	| class prop renderedModels |
	class := OPUMLClass new.
	prop := OPUMLProperty new.
	prop name: 'prop'.
	class ownedAttributes add: prop.
	controller showInDiagramModel: class.
	renderedModels := controller canvas nodes
		                  select: [ :each | each model isNotNil ]
		                  thenCollect: [ :each | each model modelElement ].
	self assertCollection: renderedModels includesAll: { prop }.
	self assert: (controller hasControllerForModel: prop) description: 'Diagram controller must register attribute controller'
]
