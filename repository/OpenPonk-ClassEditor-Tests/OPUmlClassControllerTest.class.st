"
I am a unit test class verifying the behavior of OPUmlClassController, focusing on class rendering, attribute removal cascades, and the spatial positioning of inner compartment contents.
"
Class {
	#name : 'OPUmlClassControllerTest',
	#superclass : 'OPUmlClassifierControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests-Controllers',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Controllers'
}

{ #category : 'constants' }
OPUmlClassControllerTest class >> diagramElementClass [

	^ OPUmlClassShape
]

{ #category : 'constants' }
OPUmlClassControllerTest >> controllerClass [
	^ OPUmlClassController
]

{ #category : 'constants' }
OPUmlClassControllerTest >> modelClass [
	^ OPUMLClass
]

{ #category : 'tests' }
OPUmlClassControllerTest >> testPositionsOfContentOfAClass [

	| operation operationController nameLabelRectangle operationLabelRectangle classRectangle elements |
	operation := OPUMLOperation new.
	operation name: 'anOperation'.
	model ownedOperations add: operation.
	operationController := OPUmlOperationController new.
	operationController diagramController: diagramController.
	operationController model: operation.
	diagramController model packagedElements add: model.

	controller model: model.
	controller showInDiagram: diagramController.
	operationController showInDiagram: diagramController.
	elements := diagramController canvas nodes.
	nameLabelRectangle := (elements detect: [ :any |
			                       (any model isKindOf: OPUmlClassifierNameLabel) or: [
				                       any model ownedElements anySatisfy: [ :anyInner | anyInner isKindOf: OPUmlClassifierNameLabel ] ] ])
		                      encompassingRectangle.
	operationLabelRectangle := (elements detect: [ :any |
			                            (any model isKindOf: OPUmlOperationLabel) or: [
				                            any model ownedElements anySatisfy: [ :anyInner | anyInner isKindOf: OPUmlOperationLabel ] ] ])
		                           encompassingRectangle.
	classRectangle := (elements detect: [ :any | any model isKindOf: OPUmlClassShape ]) encompassingRectangle.
	self assert: (classRectangle containsRect: nameLabelRectangle) description: 'Name of class is outside of class shape'.
	self assert: (classRectangle containsRect: operationLabelRectangle) description: 'Name of operation is outside of class shape'.
	self deny: (operationLabelRectangle intersects: nameLabelRectangle) description: 'Name of operation is overlapping name of class'.
	self assert: nameLabelRectangle bottom <= operationLabelRectangle top description: 'Name of operation is not below name of class'
]

{ #category : 'tests - removing' }
OPUmlClassControllerTest >> testRemoveWithAttribute [

	| class |
	class := OPUMLClass new.
	class ownedAttributes add: OPUMLProperty new.

	controller model: class.
	controller showWithoutDependentInDiagram: diagramController.
	controller removeControllerAndDiagramElement.
	self assertEmpty: diagramController canvas nodes.
	self assertEmpty: diagramController controllers
]

{ #category : 'tests - diagram' }
OPUmlClassControllerTest >> testShowClassWithAttributeInDiagram [

	| prop renderedModels |
	prop := OPUMLProperty new.
	model ownedAttributes add: prop.
	diagramController showInDiagramModel: model.
	renderedModels := diagramController canvas nodes
		                  select: [ :each | each model isNotNil ]
		                  thenCollect: [ :each | each model modelElement ].
	self assertCollection: renderedModels includesAll: { prop }.
	self
		assert: (diagramController hasControllerForModel: prop)
		description: 'Diagram controller must register attribute controller when showing class'
]
