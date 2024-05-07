Class {
	#name : 'OPUmlExtensionControllerTest',
	#superclass : 'OPUmlRelationshipControllerTest',
	#instVars : [
		'artifact',
		'library',
		'baseArtifact',
		'extensionLibrary'
	],
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'accessing' }
OPUmlExtensionControllerTest >> controllerClass [
	^ OPUmlExtensionController
]

{ #category : 'construction' }
OPUmlExtensionControllerTest >> diagramElementClass [

	^ OPUmlExtensionShape
]

{ #category : 'accessing' }
OPUmlExtensionControllerTest >> modelClass [
	^ OPUMLExtension
]

{ #category : 'running' }
OPUmlExtensionControllerTest >> setUp [
	super setUp.
	diagramController model: OPUMLProfile new.
	self setUpExtension
]

{ #category : 'running' }
OPUmlExtensionControllerTest >> setUpExtension [
	artifact := OPUMLClass new name: 'Artifact'.
	library := OPUMLStereotype new name: 'Library'.
	model := OPUMLExtension new.
	(baseArtifact := OPUMLProperty new)
		name: 'base_Artifact';
		owningClass: library;
		type: artifact.
	(extensionLibrary := OPUMLExtensionEnd new)
		name: 'extension_Library';
		owningAssociation: model;
		type: library.
	model
		memberEnds:
			{baseArtifact.
			extensionLibrary}.
	model ownedEnd: extensionLibrary
]

{ #category : 'as yet unclassified' }
OPUmlExtensionControllerTest >> sourceClass [

	^ OPUMLStereotype
]

{ #category : 'tests' }
OPUmlExtensionControllerTest >> testClassBeTarget [
	| sourceController targetController |
	sourceController := diagramController
		newControllerFor: (OPUMLStereotype new name: 'A').
	targetController := diagramController
		newControllerFor: (OPUMLClass new name: 'B').
	sourceController showWithoutDependentInDiagram: diagramController.
	targetController showWithoutDependentInDiagram: diagramController.
	sourceController addAsSourceFor: controller.
	targetController addAsTargetFor: controller.
	self
		assert: (controller model memberEnds collect: #name) asArray
		equals: #(base_B extension_A).
	self
		assert: controller model memberEnds first owningClass
		equals: sourceController model.
	self
		assert: controller model memberEnds second owningClass
		equals: nil
]

{ #category : 'tests - diagram' }
OPUmlExtensionControllerTest >> testRemoveFromDiagram [

	diagramController
		showWithoutDependentInDiagramModel: artifact;
		showWithoutDependentInDiagramModel: library;
		showWithoutDependentInDiagramModel: model.
	controller := diagramController controllerForModel: model.
	controller removeController.
	self assert: diagramController canvas edges asArray equals: #(  )
]

{ #category : 'tests - model' }
OPUmlExtensionControllerTest >> testRemoveFromModel [
	diagramController
		showWithoutDependentInDiagramModel: artifact;
		showWithoutDependentInDiagramModel: library;
		showWithoutDependentInDiagramModel: model.
	controller := diagramController controllerForModel: model.
	self
		deny: (diagramController model packagedElements includes: model).
	diagramController model packagedElements add: model.
	self
		assert: (diagramController model packagedElements includes: model).
	controller removeModel.
	self assert: extensionLibrary association equals: nil.
	self assert: extensionLibrary owningClass equals: nil.
	self assert: library attributes asArray equals: #().
	self
		deny: (diagramController model packagedElements includes: model)
]

{ #category : 'tests' }
OPUmlExtensionControllerTest >> testShowInDiagram [

	diagramController
		showWithoutDependentInDiagramModel: artifact;
		showWithoutDependentInDiagramModel: library;
		showWithoutDependentInDiagramModel: model.
	self assert: (diagramController canvas edges anySatisfy: [ :each | 
			 each model isNotNil and: [ each model modelElement = model ] ])
]

{ #category : 'tests' }
OPUmlExtensionControllerTest >> testWriteNavigabilityPrecondition [
	| first second |
	first := model memberEnds first.
	second := model memberEnds second.
	self assert: first isNavigable.
	self deny: second isNavigable.
	self assert: first owningClass isNotNil.
	self assert: second owningClass isNil.
	self assert: model navigableOwnedEnds asArray equals: #()
]
