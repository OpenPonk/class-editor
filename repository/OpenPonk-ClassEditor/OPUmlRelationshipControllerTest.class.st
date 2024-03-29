Class {
	#name : #OPUmlRelationshipControllerTest,
	#superclass : #OPUmlElementControllerTest,
	#category : #'OpenPonk-ClassEditor-Tests - Controllers'
}

{ #category : #testing }
OPUmlRelationshipControllerTest class >> isAbstract [
	^ self = OPUmlRelationshipControllerTest
]

{ #category : #'as yet unclassified' }
OPUmlRelationshipControllerTest >> sourceClass [

	^ OPUMLClass
]

{ #category : #'as yet unclassified' }
OPUmlRelationshipControllerTest >> targetClass [

	^ OPUMLClass
]

{ #category : #'tests - creation' }
OPUmlRelationshipControllerTest >> testCanClassBeSource [
	self assert: (OPUmlClassController new canBeSourceFor: controller)
]

{ #category : #'tests - creation' }
OPUmlRelationshipControllerTest >> testCanClassBeTarget [
	self assert: (OPUmlClassController new canBeTargetFor: controller)
]

{ #category : #'tests - creation' }
OPUmlRelationshipControllerTest >> testClassBeSource [
	| source |
	source := OPUmlClassController new.
	source addAsSourceFor: controller.
	self assert: controller source equals: source
]

{ #category : #'tests - creation' }
OPUmlRelationshipControllerTest >> testClassBeTarget [
	self subclassResponsibility
]

{ #category : #'tests - creation' }
OPUmlRelationshipControllerTest >> testConnectionFeedback [

	| sourceController targetController feedback feedbackLine edgeCreationTargetController |
	sourceController := diagramController newControllerFor:
		                    (self sourceClass new name: 'A').
	targetController := diagramController newControllerFor:
		                    (self targetClass new name: 'B').
	sourceController showWithoutDependentInDiagram: diagramController.
	targetController showWithoutDependentInDiagram: diagramController.

	sourceController addAsSourceFor: controller.
	edgeCreationTargetController := OPEdgeCreationTargetController 
		                                renderForEdgeController: controller.
	feedback := controller showAcceptFeedbackFor: controller.
	self assert: diagramController canvas lines isNotEmpty.
	feedbackLine := diagramController canvas lines first.
	self assert: feedbackLine from equals: sourceController roassalShape.
	targetController addAsTargetFor: controller.
	feedbackLine remove.
	self deny: (diagramController canvas lines includes: feedbackLine)
]
