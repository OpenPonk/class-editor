Class {
	#name : #OPUmlElementControllerTest,
	#superclass : #OPElementControllerTest,
	#category : #'OpenPonk-ClassEditor-Tests - Controllers'
}

{ #category : #testing }
OPUmlElementControllerTest class >> isAbstract [
	^ self = OPUmlElementControllerTest
]

{ #category : #accessing }
OPUmlElementControllerTest >> diagramControllerClass [

	^ OPUmlPackageDiagramController
]

{ #category : #accessing }
OPUmlElementControllerTest >> diagramModelClass [

	^ OPUMLPackage
]

{ #category : #'tests - model' }
OPUmlElementControllerTest >> testModelClass [
	self assert: controller modelClass equals: self modelClass
]
