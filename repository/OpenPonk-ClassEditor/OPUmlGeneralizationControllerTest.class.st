Class {
	#name : #OPUmlGeneralizationControllerTest,
	#superclass : #OPUmlRelationshipControllerTest,
	#instVars : [
		'parent',
		'child'
	],
	#category : #'OpenPonk-ClassEditor-Tests - Controllers'
}

{ #category : #accessing }
OPUmlGeneralizationControllerTest >> controllerClass [
	^ OPUmlGeneralizationController
]

{ #category : #construction }
OPUmlGeneralizationControllerTest >> diagramElementClass [

	^ OPUmlGeneralizationShape
]

{ #category : #accessing }
OPUmlGeneralizationControllerTest >> modelClass [
	^ OPUMLGeneralization
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
	model := OPUMLGeneralization new.
	model
		general: parent;
		specific: child
]

{ #category : #tests }
OPUmlGeneralizationControllerTest >> testClassBeTarget [
	| sourceController targetController |
	sourceController := diagramController
		newControllerFor: (OPUMLClass new name: 'A').
	targetController := diagramController
		newControllerFor: (OPUMLClass new name: 'B').
	sourceController showWithoutDependentInDiagram: diagramController.
	targetController showWithoutDependentInDiagram: diagramController.
	sourceController addAsSourceFor: controller.
	targetController addAsTargetFor: controller.
	self
		assert: sourceController model generalizations asArray
		equals: {controller model}.
	self assert: controller model general equals: targetController model
]

{ #category : #tests }
OPUmlGeneralizationControllerTest >> testDescriptionName [

	self assert: controller descriptionName equals: nil
]

{ #category : #'tests - diagram' }
OPUmlGeneralizationControllerTest >> testRemoveFromDiagram [

	diagramController
		showWithoutDependentInDiagramModel: parent;
		showWithoutDependentInDiagramModel: child.
	diagramController showWithoutDependentInDiagramModel: model.
	controller := diagramController controllerForModel: model.
	controller removeController.
	self assert: diagramController canvas edges asArray equals: #(  )
]

{ #category : #'tests - model' }
OPUmlGeneralizationControllerTest >> testRemoveFromModel [
	| gs |
	diagramController
		showWithoutDependentInDiagramModel: parent;
		showWithoutDependentInDiagramModel: child;
		showWithoutDependentInDiagramModel: model.
	gs := OPUMLGeneralizationSet new.
	gs generalizations add: model.
	self deny: (diagramController model packagedElements includes: gs).
	diagramController model
		packagedElements: diagramController model packagedElements , {gs}.
	self assert: (diagramController model packagedElements includes: gs).
	controller := diagramController controllerForModel: model.
	controller removeModel.
	self assert: child generalizations asArray equals: #().
	self assert: model generalizationSets asArray equals: #().
	self assert: gs generalizations asArray equals: #().
	self deny: (diagramController model packagedElements includes: gs)
]

{ #category : #'tests - diagram' }
OPUmlGeneralizationControllerTest >> testShowInDiagram [

	diagramController
		showWithoutDependentInDiagramModel: parent;
		showWithoutDependentInDiagramModel: child.
	diagramController showWithoutDependentInDiagramModel: model.
	self assert: (diagramController canvas edges anySatisfy: [ :each | 
			 each model isNotNil and: [ 
				 each model modelElement = model ] ])
]
