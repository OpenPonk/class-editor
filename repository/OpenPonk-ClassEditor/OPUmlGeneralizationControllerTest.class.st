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
