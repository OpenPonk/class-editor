Class {
	#name : #OPUmlExtensionControllerTest,
	#superclass : #OPUmlRelationshipControllerTest,
	#instVars : [
		'artifact',
		'library',
		'extension',
		'baseArtifact',
		'extensionLibrary'
	],
	#category : #'OpenPonk-ClassEditor-Tests - Controllers'
}

{ #category : #accessing }
OPUmlExtensionControllerTest >> controllerClass [
	^ OPUmlExtensionController
]

{ #category : #accessing }
OPUmlExtensionControllerTest >> modelClass [
	^ OPUMLExtension
]

{ #category : #running }
OPUmlExtensionControllerTest >> setUp [
	super setUp.
	diagramController model: OPUMLProfile new.
	self setUpExtension
]

{ #category : #running }
OPUmlExtensionControllerTest >> setUpExtension [
	artifact := OPUMLClass new name: 'Artifact'.
	library := OPUMLStereotype new name: 'Library'.
	extension := OPUMLExtension new.
	(baseArtifact := OPUMLProperty new)
		name: 'base_Artifact';
		owningClass: library;
		type: artifact.
	(extensionLibrary := OPUMLExtensionEnd new)
		name: 'extension_Library';
		owningAssociation: extension;
		type: library.
	extension
		memberEnds:
			{baseArtifact.
			extensionLibrary}.
	extension ownedEnd: extensionLibrary
]

{ #category : #tests }
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

{ #category : #tests }
OPUmlExtensionControllerTest >> testCreateDiagramElement [
	controller model: extension.
	self assert: controller createDiagramElement class equals: OPUmlExtensionShape
]

{ #category : #'tests - diagram' }
OPUmlExtensionControllerTest >> testRemoveFromDiagram [

	diagramController
		showWithoutDependentInDiagramModel: artifact;
		showWithoutDependentInDiagramModel: library;
		showWithoutDependentInDiagramModel: extension.
	controller := diagramController controllerForModel: extension.
	controller remove.
	self assert: diagramController view geomEdges asArray equals: #(  )
]

{ #category : #'tests - model' }
OPUmlExtensionControllerTest >> testRemoveFromModel [
	diagramController
		showWithoutDependentInDiagramModel: artifact;
		showWithoutDependentInDiagramModel: library;
		showWithoutDependentInDiagramModel: extension.
	controller := diagramController controllerForModel: extension.
	self
		deny: (diagramController model packagedElements includes: extension).
	diagramController model packagedElements add: extension.
	self
		assert: (diagramController model packagedElements includes: extension).
	controller removeModel.
	self assert: extensionLibrary association equals: nil.
	self assert: extensionLibrary owningClass equals: nil.
	self assert: library attributes asArray equals: #().
	self
		deny: (diagramController model packagedElements includes: extension)
]

{ #category : #tests }
OPUmlExtensionControllerTest >> testShowInDiagram [

	diagramController
		showWithoutDependentInDiagramModel: artifact;
		showWithoutDependentInDiagramModel: library;
		showWithoutDependentInDiagramModel: extension.
	self assert:
		(diagramController view geomEdges anySatisfy: [ :each | 
			 each model isNotNil and: [ each model modelElement = extension ] ])
]

{ #category : #tests }
OPUmlExtensionControllerTest >> testSupport [
	self
		assert: (diagramController hasSupportForModel: self modelClass new)
]

{ #category : #tests }
OPUmlExtensionControllerTest >> testWriteNavigabilityPrecondition [
	| first second |
	first := extension memberEnds first.
	second := extension memberEnds second.
	self assert: first isNavigable.
	self deny: second isNavigable.
	self assert: first owningClass isNotNil.
	self assert: second owningClass isNil.
	self assert: extension navigableOwnedEnds asArray equals: #()
]
