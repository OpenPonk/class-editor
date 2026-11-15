"
I am a unit test class verifying the behavior of OPUmlEnumerationController, ensuring enumerations correctly render and manage their literal items.
"
Class {
	#name : 'OPUmlEnumerationControllerTest',
	#superclass : 'OPUmlClassifierControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests-Controllers',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Controllers'
}

{ #category : 'constants' }
OPUmlEnumerationControllerTest class >> diagramElementClass [

	^ OPUmlEnumerationShape
]

{ #category : 'constants' }
OPUmlEnumerationControllerTest >> controllerClass [
	^ OPUmlEnumerationController
]

{ #category : 'constants' }
OPUmlEnumerationControllerTest >> modelClass [
	^ OPUMLEnumeration
]

{ #category : 'tests - removing' }
OPUmlEnumerationControllerTest >> testRemoveWithLiteral [

	model ownedLiterals add: OPUMLEnumerationLiteral new.

	controller model: model.
	controller showWithoutDependentInDiagram: diagramController.
	controller removeControllerAndDiagramElement.
	self assertEmpty: diagramController canvas nodes.
	self assertEmpty: diagramController controllers
]

{ #category : 'tests - diagram' }
OPUmlEnumerationControllerTest >> testShowWithLiteralsInDiagram [

	| literal renderedModels |
	literal := OPUMLEnumerationLiteral new name: 'enumLiteral'.
	model ownedLiterals add: literal.
	diagramController showInDiagramModel: model.
	renderedModels := diagramController canvas nodes
		                  select: [ :each | each model isNotNil ]
		                  thenCollect: [ :each | each model modelElement ].
	self assertCollection: renderedModels includesAll: { literal }.
	self
		assert: (diagramController hasControllerForModel: literal)
		description: 'Diagram controller must register literal controller when showing enumeration'
]
