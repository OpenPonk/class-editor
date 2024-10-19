Class {
	#name : 'OPUmlPackageControllerTest',
	#superclass : 'OPUmlElementControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'accessing' }
OPUmlPackageControllerTest >> controllerClass [
	^ OPUmlPackageController
]

{ #category : 'construction' }
OPUmlPackageControllerTest >> diagramElementClass [

	^ OPUmlPackageShape
]

{ #category : 'accessing' }
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
	self assert: diagramController canvas nodes isEmpty.
	controller showWithoutDependentInDiagram: diagramController.
	self assert: diagramController canvas nodes isNotEmpty.
	controller removeControllerAndDiagramElement.
	self assert: diagramController canvas nodes isEmpty.
	self assert: diagramController controllers isEmpty
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
