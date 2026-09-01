"
I am a unit test class verifying the behavior of OPUmlGeneralizationController, focusing on source/target assignments and description configurations.
"
Class {
	#name : 'OPUmlGeneralizationControllerTest',
	#superclass : 'OPUmlRelationshipControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'constants' }
OPUmlGeneralizationControllerTest class >> diagramElementClass [

	^ OPUmlGeneralizationShape
]

{ #category : 'initialization' }
OPUmlGeneralizationControllerTest >> assignModelSource [
	model specific: sourceModel
]

{ #category : 'initialization' }
OPUmlGeneralizationControllerTest >> assignModelTarget [
	model general: targetModel
]

{ #category : 'constants' }
OPUmlGeneralizationControllerTest >> controllerClass [
	^ OPUmlGeneralizationController
]

{ #category : 'constants' }
OPUmlGeneralizationControllerTest >> modelClass [
	^ OPUMLGeneralization
]

{ #category : 'tests' }
OPUmlGeneralizationControllerTest >> testDescriptionName [

	self prepareToShow.
	self assert: controller viewModel descriptionName equals: nil
]
