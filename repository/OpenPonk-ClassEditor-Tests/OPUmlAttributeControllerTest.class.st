"
I am a unit test class verifying the behavior of OPUmlAttributeController, ensuring correct UI description accessors, multiplicity formatting, and label rendering.
"
Class {
	#name : 'OPUmlAttributeControllerTest',
	#superclass : 'OPUmlClassifierItemControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests-Controllers',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Controllers'
}

{ #category : 'constants' }
OPUmlAttributeControllerTest class >> diagramElementClass [

	^ OPUmlAttributeLabel
]

{ #category : 'constants' }
OPUmlAttributeControllerTest >> controllerClass [
	^ OPUmlAttributeController
]

{ #category : 'constants' }
OPUmlAttributeControllerTest >> modelClass [
	^ OPUMLProperty
]

{ #category : 'tests - creation' }
OPUmlAttributeControllerTest >> testCanClassBeTarget [

	| classController |
	classController := OPUmlClassController new.
	self
		assert: (classController canBeTargetFor: controller)
		description: 'Class controller must accept attribute controller as target'
]

{ #category : 'tests' }
OPUmlAttributeControllerTest >> testDescriptionAccessorRead [

	| accessor vm |
	controller model: model.
	vm := controller viewModel.
	accessor := vm descriptionAccessor: #isDerived.
	controller diagramElement: Mock new.
	model isDerived: true.

	self assert: (accessor read: vm) description: 'Accessor must read true when property isDerived is true'.
	model isDerived: false.
	self deny: (accessor read: vm) description: 'Accessor must read false when property isDerived is false'
]

{ #category : 'tests' }
OPUmlAttributeControllerTest >> testDescriptionAccessorWrite [

	| accessor vm |
	controller model: model.
	vm := controller viewModel.
	accessor := vm descriptionAccessor: #isDerived.

	controller diagramElement: Mock new.
	accessor write: true to: vm.
	self assert: model isDerived description: 'Accessor write: true must set model isDerived to true'.
	accessor write: false to: vm.
	self deny: model isDerived description: 'Accessor write: false must set model isDerived to false'
]

{ #category : 'tests' }
OPUmlAttributeControllerTest >> testDescriptions [

	| container |
	controller
		diagramController: diagramController;
		model: OPUMLProperty new.
	container := controller viewModel magritteDescription.
	self assertCollection: (container children collect: #label) includesAll: #( 'Name' 'Is Derived' )
]

{ #category : 'tests' }
OPUmlAttributeControllerTest >> testDoesNotShowNilName [

	model name: nil.

	self testCreateDiagramElement.

	self assert: model name equals: 'attribute'.
	self assert: controller diagramElement text equals: 'attribute'
]

{ #category : 'tests' }
OPUmlAttributeControllerTest >> testDoesShowsBlankLabel [

	model name: ' '.
	self showInDiagram.

	self assert: controller diagramElement text equals: 'attribute'.
	self assert: controller roassalShape text equals: 'attribute'.
	self
		assert: controller roassalShape width > 5
		description: 'Rendered attribute label with blank name must use non-empty placeholder width'
]

{ #category : 'tests' }
OPUmlAttributeControllerTest >> testDoesShowsLabel [

	model name: 'attribute'.
	self showInDiagram.

	self assert: controller diagramElement text equals: 'attribute'.
	self assert: controller roassalShape text equals: 'attribute'.
	self assert: controller roassalShape width > 5 description: 'Rendered attribute label must have positive text width'
]

{ #category : 'tests' }
OPUmlAttributeControllerTest >> testDoesShowsNilLabel [

	model name: nil.
	self showInDiagram.

	self assert: controller diagramElement text equals: 'attribute'.
	self assert: controller roassalShape text equals: 'attribute'.
	self
		assert: controller roassalShape width > 5
		description: 'Rendered attribute label with nil name must use non-empty placeholder width'
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
	controller removeControllerAndDiagramElement.
	self assertEmpty: compartment ownedElements
]

{ #category : 'tests' }
OPUmlAttributeControllerTest >> testWriteMultiplicity [
	| prop |
	prop := OPUMLProperty new.
	controller model: model.
	controller viewModel writeMultiplicityFrom: '3..*' to: prop.
	self assert: prop lowerBound value equals: 3.
	self assert: prop upperBound value equals: '*'
]

{ #category : 'tests' }
OPUmlAttributeControllerTest >> testWriteMultiplicityMany [
	| prop pairs |
	prop := OPUMLProperty new.
	controller model: model.
	pairs := {
		('0..1' -> #( 0 1 )).
		('4' -> #( 4 4 )).
		('3..*' -> #( 3 '*' )).
		('*' -> #( 0 '*' )) }.
	pairs do: [ :pair |
		controller viewModel writeMultiplicityFrom: pair key to: prop.
		self assert: prop lowerBound equals: pair value first.
		self assert: prop upperBound value equals: pair value second ]
]
