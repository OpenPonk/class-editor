Class {
	#name : 'OPUmlPackageImportControllerTest',
	#superclass : 'OPUmlRelationshipControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'accessing' }
OPUmlPackageImportControllerTest >> controllerClass [
	^ OPUmlPackageImportController
]

{ #category : 'construction' }
OPUmlPackageImportControllerTest >> diagramElementClass [

	^ OPUmlPackageImportShape
]

{ #category : 'accessing' }
OPUmlPackageImportControllerTest >> modelClass [
	^ OPUMLPackageImport
]

{ #category : 'as yet unclassified' }
OPUmlPackageImportControllerTest >> sourceControllerClass [

	^ OPUmlPackageController
]

{ #category : 'as yet unclassified' }
OPUmlPackageImportControllerTest >> sourceModelClass [

	^ OPUMLPackage
]

{ #category : 'tests - construction' }
OPUmlPackageImportControllerTest >> testCanClassBeSource [
	self assert: (OPUmlPackageController new canBeSourceFor: controller)
]

{ #category : 'tests - construction' }
OPUmlPackageImportControllerTest >> testCanClassBeTarget [
	self assert: (OPUmlPackageController new canBeTargetFor: controller)
]

{ #category : 'tests - construction' }
OPUmlPackageImportControllerTest >> testClassBeSource [
	| source |
	source := OPUmlPackageController new.
	source addAsSourceFor: controller.
	self assert: controller source equals: source
]

{ #category : 'tests' }
OPUmlPackageImportControllerTest >> testDescriptionName [

	self assert: controller descriptionName equals: nil
]
