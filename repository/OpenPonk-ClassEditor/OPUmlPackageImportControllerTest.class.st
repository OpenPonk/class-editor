Class {
	#name : 'OPUmlPackageImportControllerTest',
	#superclass : 'OPUmlRelationshipControllerTest',
	#instVars : [
		'importingNamespace',
		'importedPackage'
	],
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

{ #category : 'running' }
OPUmlPackageImportControllerTest >> setUp [
	super setUp.
	self setUpModel
]

{ #category : 'running' }
OPUmlPackageImportControllerTest >> setUpModel [
	importingNamespace := OPUMLPackage new name: 'Importing Namespace'.
	importedPackage := OPUMLPackage new name: 'Imported Package'.
	model := OPUMLPackageImport new
		importingNamespace: importingNamespace;
		importedPackage: importedPackage
]

{ #category : 'as yet unclassified' }
OPUmlPackageImportControllerTest >> sourceClass [

	^ OPUMLPackage
]

{ #category : 'as yet unclassified' }
OPUmlPackageImportControllerTest >> targetClass [

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

{ #category : 'tests - construction' }
OPUmlPackageImportControllerTest >> testClassBeTarget [
	| sourceController targetController |
	sourceController := diagramController
		newControllerFor: (OPUMLPackage new name: 'A').
	targetController := diagramController
		newControllerFor: (OPUMLPackage new name: 'B').
	sourceController showWithoutDependentInDiagram: diagramController.
	targetController showWithoutDependentInDiagram: diagramController.
	sourceController addAsSourceFor: controller.
	targetController addAsTargetFor: controller.
	self
		assert: sourceController model packageImports asArray
		equals: {controller model}.
	self
		assert: controller model importedPackage
		equals: targetController model
]

{ #category : 'tests' }
OPUmlPackageImportControllerTest >> testDescriptionName [

	self assert: controller descriptionName equals: nil
]

{ #category : 'tests - diagram' }
OPUmlPackageImportControllerTest >> testRemoveFromDiagram [

	diagramController
		showWithoutDependentInDiagramModel: importingNamespace;
		showWithoutDependentInDiagramModel: importedPackage.
	diagramController showWithoutDependentInDiagramModel: model.
	controller := diagramController controllerForModel: model.
	controller removeController.
	self assert: diagramController canvas edges asArray equals: #(  )
]

{ #category : 'tests - model' }
OPUmlPackageImportControllerTest >> testRemoveFromModel [
	diagramController
		showWithoutDependentInDiagramModel: importingNamespace;
		showWithoutDependentInDiagramModel: importedPackage;
		showWithoutDependentInDiagramModel: model.
	controller := diagramController controllerForModel: model.
	controller removeModel.
	self assert: importedPackage packageImports asArray equals: #()
]

{ #category : 'tests - diagram' }
OPUmlPackageImportControllerTest >> testShowInDiagram [

	diagramController
		showWithoutDependentInDiagramModel: importingNamespace;
		showWithoutDependentInDiagramModel: importedPackage.
	diagramController showWithoutDependentInDiagramModel: model.
	self assert: (diagramController canvas edges anySatisfy: [ :each | 
			 each model isNotNil and: [ 
				 each model modelElement = model ] ])
]
