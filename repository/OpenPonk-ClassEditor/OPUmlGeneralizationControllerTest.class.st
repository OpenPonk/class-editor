Class {
	#name : 'OPUmlGeneralizationControllerTest',
	#superclass : 'OPUmlRelationshipControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'accessing' }
OPUmlGeneralizationControllerTest >> controllerClass [
	^ OPUmlGeneralizationController
]

{ #category : 'construction' }
OPUmlGeneralizationControllerTest >> diagramElementClass [

	^ OPUmlGeneralizationShape
]

{ #category : 'accessing' }
OPUmlGeneralizationControllerTest >> modelClass [
	^ OPUMLGeneralization
]

{ #category : 'tests' }
OPUmlGeneralizationControllerTest >> testDescriptionName [

	self assert: controller descriptionName equals: nil
]

{ #category : 'tests' }
OPUmlGeneralizationControllerTest >> testGeneralizationSet [

	| set |
	self showInDiagram.
	self
		assertCollection: diagramController model packagedElements
		hasSameElements: {
				sourceModel.
				targetModel }.
	set := OPUMLGeneralizationSet new.
	controller
		write: { (OPUmlGeneralizationSetDescriptions new
				 controller: controller;
				 set: set;
				 yourself) }
		using: controller descriptionGeneralizationSet.
	self
		assertCollection: diagramController model packagedElements
		hasSameElements: {
				sourceModel.
				targetModel.
				set }.
	controller removeModel.
	self
		assertCollection: diagramController model packagedElements
		hasSameElements: {
				sourceModel.
				targetModel }
]
