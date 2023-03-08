Class {
	#name : #OPUmlElementControllerTest,
	#superclass : #OPBaseControllerTest,
	#category : #'OpenPonk-ClassEditor-Tests - Controllers'
}

{ #category : #testing }
OPUmlElementControllerTest class >> isAbstract [
	^ self = OPUmlElementControllerTest
]

{ #category : #'tests - model' }
OPUmlElementControllerTest >> testModelClass [
	self assert: controller modelClass equals: self modelClass
]
