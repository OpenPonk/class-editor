"
I am a unit test class verifying the behavior of OPUmlStereotypeController, specifically testing the rendering of stereotypes, their attributes, and canvas targeting.
"
Class {
	#name : 'OPUmlStereotypeControllerTest',
	#superclass : 'OPUmlElementControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests-Controllers',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Controllers'
}

{ #category : 'constants' }
OPUmlStereotypeControllerTest class >> diagramElementClass [

	^ OPUmlStereotypeShape
]

{ #category : 'constants' }
OPUmlStereotypeControllerTest >> controllerClass [
	^ OPUmlStereotypeController
]

{ #category : 'constants' }
OPUmlStereotypeControllerTest >> modelClass [
	^ OPUMLStereotype
]

{ #category : 'instance creation' }
OPUmlStereotypeControllerTest >> newEmptyClass [
	^ OPUMLStereotype new name: 'Something'
]

{ #category : 'instance creation' }
OPUmlStereotypeControllerTest >> newEmptyModel [
	^ OPUMLStereotype new name: 'Something'
]

{ #category : 'tests - creation' }
OPUmlStereotypeControllerTest >> testAddDiagramAsTargetForClass [
	diagramController addAsTargetFor: controller.
	self assert: diagramController model packagedElements asArray equals: {controller model}
]

{ #category : 'tests - creation' }
OPUmlStereotypeControllerTest >> testCanDiagramBeTargetForClass [

	self
		assert: (diagramController canBeTargetFor: controller)
		description: 'Diagram controller must accept stereotype controller as target'
]

{ #category : 'tests - creation' }
OPUmlStereotypeControllerTest >> testCreateFromPalette [

	self
		assert: (diagramController canBeTargetFor: controller)
		description: 'Diagram controller must allow creating stereotype from palette'
]

{ #category : 'tests - removing' }
OPUmlStereotypeControllerTest >> testRemoveEmpty [

	| class |
	class := self newEmptyModel.

	controller model: class.
	controller showWithoutDependentInDiagram: diagramController.
	controller removeControllerAndDiagramElement.
	self assertEmpty: diagramController canvas nodes.
	self assertEmpty: diagramController controllers
]

{ #category : 'tests - removing' }
OPUmlStereotypeControllerTest >> testRemoveWithAttribute [

	| class |
	class := self newEmptyModel.
	class ownedAttributes add: OPUMLProperty new.

	controller model: class.
	controller showWithoutDependentInDiagram: diagramController.
	controller removeControllerAndDiagramElement.
	self assertEmpty: diagramController canvas nodes.
	self assertEmpty: diagramController controllers
]

{ #category : 'tests - diagram' }
OPUmlStereotypeControllerTest >> testShowClassInDiagram [

	| class renderedModels |
	class := self newEmptyModel.
	diagramController showWithoutDependentInDiagramModel: class.
	renderedModels := diagramController canvas nodes
		                  select: [ :each | each model isNotNil ]
		                  thenCollect: [ :each | each model modelElement ].
	self assertCollection: renderedModels includesAll: { class }.
	self
		assert: (diagramController hasControllerForModel: class)
		description: 'Diagram controller must register stereotype controller'
]

{ #category : 'tests - diagram' }
OPUmlStereotypeControllerTest >> testShowClassWithAttributeInDiagram [

	| class prop renderedModels |
	class := self newEmptyModel.
	prop := OPUMLProperty new.
	class ownedAttributes add: prop.
	diagramController showInDiagramModel: class.
	renderedModels := diagramController canvas nodes
		                  select: [ :each | each model isNotNil ]
		                  thenCollect: [ :each | each model modelElement ].
	self assertCollection: renderedModels includesAll: { prop }.
	self
		assert: (diagramController hasControllerForModel: prop)
		description: 'Diagram controller must register attribute controller for stereotype property'
]
