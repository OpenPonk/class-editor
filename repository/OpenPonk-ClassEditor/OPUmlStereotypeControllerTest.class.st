"
I am a unit test class verifying the behavior of OPUmlStereotypeController, specifically testing the rendering of stereotypes, their attributes, and canvas targeting.
"
Class {
	#name : 'OPUmlStereotypeControllerTest',
	#superclass : 'OPUmlElementControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
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
	self assert: (diagramController canBeTargetFor: controller)
]

{ #category : 'tests - creation' }
OPUmlStereotypeControllerTest >> testCreateFromPalette [
	self assert: (diagramController canBeTargetFor: controller)
]

{ #category : 'tests - removing' }
OPUmlStereotypeControllerTest >> testRemoveEmpty [

	| class |
	class := self newEmptyModel.

	controller model: class.
	controller showWithoutDependentInDiagram: diagramController.
	controller removeControllerAndDiagramElement.
	self assert: diagramController canvas nodes asArray equals: #(  ).
	self assert: diagramController controllers asArray equals: #(  )
]

{ #category : 'tests - removing' }
OPUmlStereotypeControllerTest >> testRemoveWithAttribute [

	| class |
	class := self newEmptyModel.
	class ownedAttributes add: OPUMLProperty new.

	controller model: class.
	controller showWithoutDependentInDiagram: diagramController.
	controller removeControllerAndDiagramElement.
	self assert: diagramController canvas nodes asArray equals: #(  ).
	self assert: diagramController controllers asArray equals: #(  )
]

{ #category : 'tests - diagram' }
OPUmlStereotypeControllerTest >> testShowClassInDiagram [

	| class |
	class := self newEmptyModel.
	diagramController showWithoutDependentInDiagramModel: class.
	self assert: (diagramController canvas nodes anySatisfy: [ :each | 
			 each model isNotNil and: [ each model modelElement = class ] ])
]

{ #category : 'tests - diagram' }
OPUmlStereotypeControllerTest >> testShowClassWithAttributeInDiagram [

	| class prop |
	class := self newEmptyModel.
	prop := OPUMLProperty new.
	class ownedAttributes add: prop.
	diagramController showInDiagramModel: class.
	self assert: (diagramController canvas nodes anySatisfy: [ :each | 
			 each model isNotNil and: [ each model modelElement = prop ] ])
]
