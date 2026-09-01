"
I am a unit test class verifying the behavior of OPUmlEnumerationLiteralController, testing its attachment to and removal from parent Enumeration controllers.
"
Class {
	#name : 'OPUmlEnumLiteralControllerTest',
	#superclass : 'OPUmlClassifierItemControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'constants' }
OPUmlEnumLiteralControllerTest class >> diagramElementClass [

	^ OPUmlEnumerationLiteralLabel
]

{ #category : 'constants' }
OPUmlEnumLiteralControllerTest >> controllerClass [
	^ OPUmlEnumerationLiteralController
]

{ #category : 'constants' }
OPUmlEnumLiteralControllerTest >> creationTargetControllerClass [

	^ OPUmlEnumerationController
]

{ #category : 'constants' }
OPUmlEnumLiteralControllerTest >> creationTargetModelClass [

	^ OPUMLEnumeration
]

{ #category : 'constants' }
OPUmlEnumLiteralControllerTest >> modelClass [
	^ OPUMLEnumerationLiteral
]

{ #category : 'tests - creation' }
OPUmlEnumLiteralControllerTest >> testCanEnumerationBeTarget [
	| classController |
	classController := OPUmlEnumerationController new.
	self assert: (classController canBeTargetFor: controller)
]

{ #category : 'tests - creation' }
OPUmlEnumLiteralControllerTest >> testCreateDiagramElement [

	model enumeration: OPUMLEnumeration new.
	diagramController showWithoutDependentInDiagramModel: model enumeration.

	super testCreateDiagramElement
]

{ #category : 'tests - creation' }
OPUmlEnumLiteralControllerTest >> testEnumerationBeTarget [
	| classController |
	classController := diagramController
		newControllerFor: OPUMLEnumeration new.
	classController showWithoutDependentInDiagram: diagramController.
	classController addAsTargetFor: controller.
	self
		assert: classController model ownedLiterals asArray
		equals: {controller model}
]

{ #category : 'tests - removing' }
OPUmlEnumLiteralControllerTest >> testRemoveFromView [

	| class compartment prop |
	class := OPUMLClass new.
	prop := OPUMLProperty new.
	class ownedAttributes add: prop.
	diagramController showInDiagramModel: class.
	controller := diagramController controllerForModel: prop.
	compartment := controller diagramElement owningElement.
	controller removeControllerAndDiagramElement.
	self assert: compartment ownedElements asArray equals: #(  )
]
