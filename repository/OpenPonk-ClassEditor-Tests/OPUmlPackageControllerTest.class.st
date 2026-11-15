"
I am a unit test class verifying the behavior of OPUmlPackageController, checking diagram targets, creation from palettes, and rendering nested elements.
"
Class {
	#name : 'OPUmlPackageControllerTest',
	#superclass : 'OPUmlElementControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests-Controllers',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Controllers'
}

{ #category : 'constants' }
OPUmlPackageControllerTest class >> diagramElementClass [

	^ OPUmlPackageShape
]

{ #category : 'constants' }
OPUmlPackageControllerTest >> controllerClass [
	^ OPUmlPackageController
]

{ #category : 'constants' }
OPUmlPackageControllerTest >> modelClass [
	^ OPUMLPackage
]

{ #category : 'instance creation' }
OPUmlPackageControllerTest >> newEmptyModel [
	^ OPUMLPackage new name: 'Something'
]

{ #category : 'tests - creation' }
OPUmlPackageControllerTest >> testAddDiagramAsTargetForModel [
	diagramController addAsTargetFor: controller.
	self assert: diagramController model packagedElements asArray equals: {controller model}
]

{ #category : 'tests - creation' }
OPUmlPackageControllerTest >> testCanDiagramBeTargetForModel [

	self
		assert: (diagramController canBeTargetFor: controller)
		description: 'Diagram controller must accept package controller as target'
]

{ #category : 'tests - creation' }
OPUmlPackageControllerTest >> testCreateFromPalette [

	self
		assert: (diagramController canBeTargetFor: controller)
		description: 'Diagram controller must allow creating package from palette'
]

{ #category : 'tests - removing' }
OPUmlPackageControllerTest >> testRemoveEmpty [

	controller model: self newEmptyModel.
	self assertEmpty: diagramController canvas nodes.
	controller showWithoutDependentInDiagram: diagramController.
	self denyEmpty: diagramController canvas nodes.
	controller removeControllerAndDiagramElement.
	self assertEmpty: diagramController canvas nodes.
	self assertEmpty: diagramController controllers
]

{ #category : 'tests - diagram' }
OPUmlPackageControllerTest >> testShowClassInDiagram [

	| class renderedModels |
	class := OPUMLClass new.
	diagramController showWithoutDependentInDiagramModel: class.
	renderedModels := diagramController canvas nodes
		                  select: [ :each | each model isNotNil ]
		                  thenCollect: [ :each | each model modelElement ].
	self assertCollection: renderedModels includesAll: { class }.
	self assert: (diagramController hasControllerForModel: class) description: 'Diagram controller must register class controller'
]

{ #category : 'tests - diagram' }
OPUmlPackageControllerTest >> testShowClassWithAttributeInDiagram [

	| class prop renderedModels |
	class := OPUMLClass new.
	prop := OPUMLProperty new.
	class ownedAttributes add: prop.
	diagramController showInDiagramModel: class.
	renderedModels := diagramController canvas nodes
		                  select: [ :each | each model isNotNil ]
		                  thenCollect: [ :each | each model modelElement ].
	self assertCollection: renderedModels includesAll: { prop }.
	self assert: (diagramController hasControllerForModel: prop) description: 'Diagram controller must register attribute controller'
]
