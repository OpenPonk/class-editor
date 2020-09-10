Class {
	#name : #OPUmlPackageImportControllerTest,
	#superclass : #OPUmlRelationshipControllerTest,
	#instVars : [
		'importingNamespace',
		'importedPackage',
		'packageImport'
	],
	#category : #'OpenPonk-ClassEditor-Tests - Controllers'
}

{ #category : #accessing }
OPUmlPackageImportControllerTest >> controllerClass [
	^ OPUmlPackageImportController
]

{ #category : #accessing }
OPUmlPackageImportControllerTest >> modelClass [
	^ OPUMLPackageImport
]

{ #category : #running }
OPUmlPackageImportControllerTest >> newInstance [
	^ self modelClass new
]

{ #category : #running }
OPUmlPackageImportControllerTest >> setUp [
	super setUp.
	self setUpModel
]

{ #category : #running }
OPUmlPackageImportControllerTest >> setUpModel [
	importingNamespace := OPUMLPackage new name: 'Importing Namespace'.
	importedPackage := OPUMLPackage new name: 'Imported Package'.
	packageImport := OPUMLPackageImport new
		importingNamespace: importingNamespace;
		importedPackage: importedPackage
]

{ #category : #'tests - construction' }
OPUmlPackageImportControllerTest >> testCanClassBeSource [
	self assert: (OPUmlPackageController new canBeSourceFor: controller)
]

{ #category : #'tests - construction' }
OPUmlPackageImportControllerTest >> testCanClassBeTarget [
	self assert: (OPUmlPackageController new canBeTargetFor: controller)
]

{ #category : #'tests - construction' }
OPUmlPackageImportControllerTest >> testClassBeSource [
	| source |
	source := OPUmlPackageController new.
	source addAsSourceFor: controller.
	self assert: controller source equals: source
]

{ #category : #'tests - construction' }
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

{ #category : #'tests - construction' }
OPUmlPackageImportControllerTest >> testConnectionFeedback [
	| sourceController targetController feedback feedbackLine |
	sourceController := diagramController
		newControllerFor: (OPUMLPackage new name: 'A').
	targetController := diagramController
		newControllerFor: (OPUMLPackage new name: 'B').
	sourceController showWithoutDependentInDiagram: diagramController.
	targetController showWithoutDependentInDiagram: diagramController.
	sourceController addAsSourceFor: controller.
	feedback := controller connectionFeedback.
	feedback renderIn: diagramController view.
	self assert: diagramController view edges isNotEmpty.
	feedbackLine := diagramController view edges first.
	self assert: feedbackLine from equals: sourceController figure.
	targetController addAsTargetFor: controller.
	feedbackLine remove.
	self deny: (diagramController view edges includes: feedbackLine)
]

{ #category : #'tests - diagram' }
OPUmlPackageImportControllerTest >> testCreateDiagramElement [
	self assert: controller createDiagramElement class equals: OPUmlPackageImportShape
]

{ #category : #'tests - diagram' }
OPUmlPackageImportControllerTest >> testRemoveFromDiagram [
	diagramController
		showWithoutDependentInDiagramModel: importingNamespace;
		showWithoutDependentInDiagramModel: importedPackage.
	diagramController showWithoutDependentInDiagramModel: packageImport.
	controller := diagramController controllerForModel: packageImport.
	controller remove.
	self assert: diagramController view edges asArray equals: #()
]

{ #category : #'tests - model' }
OPUmlPackageImportControllerTest >> testRemoveFromModel [
	diagramController
		showWithoutDependentInDiagramModel: importingNamespace;
		showWithoutDependentInDiagramModel: importedPackage;
		showWithoutDependentInDiagramModel: packageImport.
	controller := diagramController controllerForModel: packageImport.
	controller removeModel.
	self assert: importedPackage packageImports asArray equals: #()
]

{ #category : #'tests - diagram' }
OPUmlPackageImportControllerTest >> testShowInDiagram [
	diagramController
		showWithoutDependentInDiagramModel: importingNamespace;
		showWithoutDependentInDiagramModel: importedPackage.
	diagramController showWithoutDependentInDiagramModel: packageImport.
	self
		assert:
			(diagramController view edges
				anySatisfy: [ :each | each model isNotNil and: [ each model modelElement = packageImport ] ])
]

{ #category : #tests }
OPUmlPackageImportControllerTest >> testSupport [
	self assert: (diagramController hasSupportForModel: self newInstance)
]
