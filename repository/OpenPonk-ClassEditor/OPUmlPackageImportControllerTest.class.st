"
I am a unit test class verifying the behavior of OPUmlPackageImportController, verifying valid source and target package/namespace assignments.
"
Class {
	#name : 'OPUmlPackageImportControllerTest',
	#superclass : 'OPUmlRelationshipControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'constants' }
OPUmlPackageImportControllerTest class >> diagramElementClass [

	^ OPUmlPackageImportShape
]

{ #category : 'initialization' }
OPUmlPackageImportControllerTest >> assignModelSource [
	model importingNamespace: sourceModel
]

{ #category : 'initialization' }
OPUmlPackageImportControllerTest >> assignModelTarget [
	model importedPackage: targetModel
]

{ #category : 'constants' }
OPUmlPackageImportControllerTest >> controllerClass [
	^ OPUmlPackageImportController
]

{ #category : 'constants' }
OPUmlPackageImportControllerTest >> modelClass [
	^ OPUMLPackageImport
]

{ #category : 'constants' }
OPUmlPackageImportControllerTest >> sourceControllerClass [

	^ OPUmlPackageController
]

{ #category : 'constants' }
OPUmlPackageImportControllerTest >> sourceModelClass [

	^ OPUMLPackage
]

{ #category : 'tests - creation' }
OPUmlPackageImportControllerTest >> testCanClassBeSource [
	self assert: (OPUmlPackageController new canBeSourceFor: controller)
]

{ #category : 'tests - creation' }
OPUmlPackageImportControllerTest >> testCanClassBeTarget [
	self assert: (OPUmlPackageController new canBeTargetFor: controller)
]

{ #category : 'tests - creation' }
OPUmlPackageImportControllerTest >> testClassBeSource [
	| source |
	source := OPUmlPackageController new.
	source addAsSourceFor: controller.
	self assert: controller source equals: source
]

{ #category : 'tests' }
OPUmlPackageImportControllerTest >> testDescriptionName [

	self prepareToShow.
	self assert: controller viewModel descriptionName equals: nil
]
