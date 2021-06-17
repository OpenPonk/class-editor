Class {
	#name : #OPUmlElementControllerTest,
	#superclass : #TestCase,
	#instVars : [
		'controller',
		'diagramController',
		'model'
	],
	#category : 'OpenPonk-ClassEditor-Tests - Controllers'
}

{ #category : #testing }
OPUmlElementControllerTest class >> isAbstract [
	^ self = OPUmlElementControllerTest
]

{ #category : #accessing }
OPUmlElementControllerTest >> controllerClass [
	^ self subclassResponsibility
]

{ #category : #accessing }
OPUmlElementControllerTest >> modelClass [
	^ self subclassResponsibility
]

{ #category : #accessing }
OPUmlElementControllerTest >> newInstance [
	^ self modelClass new name: self modelClass name uncapitalized
]

{ #category : #running }
OPUmlElementControllerTest >> setUp [
	super setUp.
	controller := self controllerClass new.
	diagramController := OPUmlPackageDiagramController new.
	diagramController model: (OPUMLPackage new name: 'TestPackage').
	diagramController view: RTView new.
	model := self newInstance
]

{ #category : #'tests - model' }
OPUmlElementControllerTest >> testModelClass [
	self assert: controller modelClass equals: self modelClass
]
