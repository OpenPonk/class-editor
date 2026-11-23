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

{ #category : 'tests - diagram' }
OPUmlEnumerationControllerTest >> testLiteralAdornmentCreatesLiteral [

	| mockWorkbench mockForm editor palette selectable adornmentBoxes |
	controller createModelIn: diagramController model.
	diagramController addController: controller.
	controller
		createDiagramElement;
		renderDiagramElement.

	mockForm := Mock new.
	mockForm stub focusFirstInput willReturn: nil.
	mockWorkbench := Mock new.
	(mockWorkbench stub openFormOn: Any) willReturn: nil.
	mockWorkbench stub form willReturn: mockForm.
	mockWorkbench stub projectController willReturn: diagramController projectController.
	editor := (OPEditor on: OPUmlClassEditorPlugin new)
		          workbench: mockWorkbench;
		          yourself.
	palette := editor palette.
	diagramController editor: editor.
	palette createPaletteFor: diagramController.

	selectable := controller roassalShape propertyAt: OPRSSelectable.
	selectable fakeClicked: controller roassalShape.
	adornmentBoxes := diagramController canvas shapes select: [ :eachShape |
		                  eachShape class == RSBox and: [ eachShape model == controller roassalShape ] ].
	self assert: adornmentBoxes size equals: 1.

	adornmentBoxes first announce: RSMouseLeftClick new.
	self assert: controller model ownedLiterals size equals: 1
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
