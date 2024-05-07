Class {
	#name : 'OPUmlAttributeControllerTest',
	#superclass : 'OPUmlElementControllerTest',
	#instVars : [
		'owningController',
		'owningClass'
	],
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'accessing' }
OPUmlAttributeControllerTest >> controllerClass [
	^ OPUmlAttributeController
]

{ #category : 'construction' }
OPUmlAttributeControllerTest >> diagramElementClass [

	^ OPUmlAttributeLabel
]

{ #category : 'accessing' }
OPUmlAttributeControllerTest >> modelClass [
	^ OPUMLProperty
]

{ #category : 'running' }
OPUmlAttributeControllerTest >> setUp [

	super setUp.
	owningClass := OPUMLClass new.
	model owningClass: owningClass.
	owningController := OPUmlClassController new model: owningClass
]

{ #category : 'tests - creation' }
OPUmlAttributeControllerTest >> testCanClassBeTarget [
	| classController |
	classController := OPUmlClassController new.
	self assert: (classController canBeTargetFor: controller)
]

{ #category : 'tests - creation' }
OPUmlAttributeControllerTest >> testClassBeTarget [

	| classController |
	classController := diagramController newControllerFor:
		                   (OPUMLClass new
			                    name: 'Class';
			                    yourself).
	classController showWithoutDependentInDiagram: diagramController.
	classController addAsTargetFor: controller.
	self
		assert: classController model ownedAttributes asArray
		equals: { controller model }
]

{ #category : 'tests' }
OPUmlAttributeControllerTest >> testCreateDiagramElement [

	diagramController showWithoutDependentInDiagramModel: owningClass.

	super testCreateDiagramElement
]

{ #category : 'tests' }
OPUmlAttributeControllerTest >> testDescriptionAccessorRead [

	| accessor |
	accessor := controller descriptionAccessor: #isDerived.
	controller diagramElement: Mock new.
	model isDerived: true.
	controller model: model.
	self assert: (accessor read: controller).
	model isDerived: false.
	self deny: (accessor read: controller)
]

{ #category : 'tests' }
OPUmlAttributeControllerTest >> testDescriptionAccessorWrite [

	| accessor |
	accessor := controller descriptionAccessor: #isDerived.
	controller model: model.
	controller diagramElement: Mock new.
	accessor write: true to: controller.
	self assert: model isDerived.
	accessor write: false to: controller.
	self deny: model isDerived
]

{ #category : 'tests' }
OPUmlAttributeControllerTest >> testDescriptions [
	| container |
	controller
		diagramController: diagramController;
		model: OPUMLProperty new.
	container := controller magritteDescription.
	self assert: (container anySatisfy: [ :each | each label = 'Name' ]).
	self
		assert: (container anySatisfy: [ :each | each label = 'Is Derived' ])
]

{ #category : 'tests' }
OPUmlAttributeControllerTest >> testDoesNotShowNilName [

	model name: nil.

	self testCreateDiagramElement.

	self assert: controller diagramElement text isNotNil.
	self assert: controller diagramElement text isNotEmpty
]

{ #category : 'tests' }
OPUmlAttributeControllerTest >> testDoesShowsBlankLabel [

	model name: ' '.
	controller model: model.
	diagramController addController: controller.
	owningController showInDiagram: diagramController.
	controller showInDiagram: diagramController.

	self assert: controller roassalShape width > 5
]

{ #category : 'tests' }
OPUmlAttributeControllerTest >> testDoesShowsLabel [

	model name: 'attribute'.
	controller model: model.
	diagramController addController: controller.
	owningController showInDiagram: diagramController.
	controller showInDiagram: diagramController.

	self assert: controller roassalShape width > 5
]

{ #category : 'tests' }
OPUmlAttributeControllerTest >> testDoesShowsNilLabel [

	model name: nil.
	controller model: model.
	diagramController addController: controller.
	owningController showInDiagram: diagramController.
	controller showInDiagram: diagramController.

	self assert: controller roassalShape width > 5
]

{ #category : 'tests - removing' }
OPUmlAttributeControllerTest >> testRemoveFromView [
	| class compartment prop |
	class := OPUMLClass new.
	prop := OPUMLProperty new.
	class ownedAttributes add: prop.
	diagramController showInDiagramModel: class.
	controller := diagramController controllerForModel: prop.
	compartment := controller diagramElement owningElement.
	controller removeController.
	self assert: compartment ownedElements asArray equals: #()
]

{ #category : 'tests' }
OPUmlAttributeControllerTest >> testWriteMultiplicity [
	| prop |
	prop := OPUMLProperty new.
	controller writeMultiplicityFrom: '3..*' to: prop.
	self assert: prop lowerBound value equals: 3.
	self assert: prop upperBound value equals: '*'
]

{ #category : 'tests' }
OPUmlAttributeControllerTest >> testWriteMultiplicityMany [
	| prop pairs |
	prop := OPUMLProperty new.
	pairs := {'0..1' -> #(0 1).
	'4' -> #(4 4).
	'3..*' -> #(3 '*').
	'*' -> #(0 '*')}.
	pairs
		do: [ :pair | 
			controller writeMultiplicityFrom: pair key to: prop.
			self assert: prop lowerBound equals: pair value first.
			self assert: prop upperBound value equals: pair value second ]
]
