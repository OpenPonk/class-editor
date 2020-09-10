Class {
	#name : #OPUmlRelationshipControllerTest,
	#superclass : #OPUmlElementControllerTest,
	#category : #'OpenPonk-ClassEditor-Tests - Controllers'
}

{ #category : #testing }
OPUmlRelationshipControllerTest class >> isAbstract [
	^ self = OPUmlRelationshipControllerTest
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
	| sourceController targetController feedback feedbackLine |
	sourceController := diagramController
		newControllerFor: (OPUMLClass new name: 'A').
	targetController := diagramController
		newControllerFor: (OPUMLClass new name: 'B').
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
