Class {
	#name : #OPUmlGeneralizationControllerTest,
	#superclass : #OPUmlRelationshipControllerTest,
	#instVars : [
		'parent',
		'child',
		'generalization'
	],
	#category : #'OpenPonk-ClassEditor-Tests - Controllers'
}

{ #category : #accessing }
OPUmlGeneralizationControllerTest >> controllerClass [
	^ OPUmlGeneralizationController
]

{ #category : #accessing }
OPUmlGeneralizationControllerTest >> modelClass [
	^ OPUMLGeneralization
]

{ #category : #running }
OPUmlGeneralizationControllerTest >> newInstance [
	^ self modelClass new
]

{ #category : #running }
OPUmlGeneralizationControllerTest >> setUp [
	super setUp.
	self setUpGeneralization
]

{ #category : #running }
OPUmlGeneralizationControllerTest >> setUpGeneralization [
	parent := OPUMLClass new name: 'Parent'.
	child := OPUMLClass new name: 'Child'.
	generalization := OPUMLGeneralization new.
	generalization
		general: parent;
		specific: child
]

{ #category : #tests }
OPUmlGeneralizationControllerTest >> testClassBeTarget [
	| sourceController targetController |
	sourceController := diagramController newControllerFor: (OPUMLClass new name: 'A').
	targetController := diagramController newControllerFor: (OPUMLClass new name: 'B').
	diagramController
		addController: sourceController;
		addController: targetController.
	sourceController showInDiagram: diagramController.
	targetController showInDiagram: diagramController.
	sourceController addAsSourceFor: controller.
	targetController addAsTargetFor: controller.
	self assert: sourceController model generalizations asArray equals: {controller model}.
	self assert: controller model general equals: targetController model
]

{ #category : #'tests - diagram' }
OPUmlGeneralizationControllerTest >> testCreateDiagramElement [
	self assert: controller createDiagramElement class equals: OPUmlGeneralizationShape
]

{ #category : #'tests - diagram' }
OPUmlGeneralizationControllerTest >> testRemoveFromDiagram [
	diagramController
		showInDiagramModel: parent;
		showInDiagramModel: child.
	diagramController showInDiagramModel: generalization.
	controller := diagramController controllerForModel: generalization.
	controller remove.
	self assert: diagramController view edges asArray equals: #()
]

{ #category : #'tests - model' }
OPUmlGeneralizationControllerTest >> testRemoveFromModel [
	| gs |
	diagramController
		showInDiagramModel: parent;
		showInDiagramModel: child;
		showInDiagramModel: generalization.
	gs := OPUMLGeneralizationSet new.
	gs generalizations add: generalization.
	controller := diagramController controllerForModel: generalization.
	controller removeModel.
	self assert: child generalizations asArray equals: #().
	self assert: generalization generalizationSets asArray equals: #().
	self assert: gs generalizations asArray equals: #()
]

{ #category : #'tests - diagram' }
OPUmlGeneralizationControllerTest >> testShowInDiagram [
	diagramController
		showInDiagramModel: parent;
		showInDiagramModel: child.
	diagramController showInDiagramModel: generalization.
	self
		assert:
			(diagramController view edges
				anySatisfy: [ :each | each model isNotNil and: [ each model modelElement = generalization ] ])
]

{ #category : #tests }
OPUmlGeneralizationControllerTest >> testSupport [
	self assert: (diagramController hasSupportForModel: OPUMLGeneralization new)
]
