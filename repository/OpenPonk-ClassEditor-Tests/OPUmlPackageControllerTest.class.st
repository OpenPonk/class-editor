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
	self assert: (diagramController canBeTargetFor: controller)
]

{ #category : 'tests - creation' }
OPUmlPackageControllerTest >> testCreateFromPalette [
	self assert: (diagramController canBeTargetFor: controller)
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

	| class |
	class := OPUMLClass new.
	diagramController showWithoutDependentInDiagramModel: class.
	self assert: (diagramController canvas nodes anySatisfy: [ :each | 
			 each model isNotNil and: [ each model modelElement = class ] ])
]

{ #category : 'tests - diagram' }
OPUmlPackageControllerTest >> testShowClassWithAttributeInDiagram [

	| class prop |
	class := OPUMLClass new.
	prop := OPUMLProperty new.
	class ownedAttributes add: prop.
	diagramController showInDiagramModel: class.
	self assert: (diagramController canvas nodes anySatisfy: [ :each | 
			 each model isNotNil and: [ each model modelElement = prop ] ])
]
