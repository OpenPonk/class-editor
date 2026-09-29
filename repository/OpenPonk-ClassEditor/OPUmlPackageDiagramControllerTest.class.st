"
I am a unit test class verifying the behavior of OPUmlPackageDiagramController, explicitly testing the correct canvas rendering of UML classes and their inner attributes.
"
Class {
	#name : 'OPUmlPackageDiagramControllerTest',
	#superclass : 'OPAbstractDiagramControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
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

	| class |
	class := OPUMLClass new.
	controller showWithoutDependentInDiagramModel: class.
	self assert: (controller canvas nodes anySatisfy: [ :each | 
			 each model isNotNil and: [ each model modelElement = class ] ])
]

{ #category : 'tests' }
OPUmlPackageDiagramControllerTest >> testShowClassWithAttributeInDiagram [

	| class prop |
	class := OPUMLClass new.
	prop := OPUMLProperty new.
	prop name: 'prop'.
	class ownedAttributes add: prop.
	controller showInDiagramModel: class.
	self assert: (controller canvas nodes anySatisfy: [ :each | 
			 each model isNotNil and: [ each model modelElement = prop ] ])
]
