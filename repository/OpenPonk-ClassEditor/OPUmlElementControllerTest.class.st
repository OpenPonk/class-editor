Class {
	#name : 'OPUmlElementControllerTest',
	#superclass : 'OPAbstractElementControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'testing' }
OPUmlElementControllerTest class >> isAbstract [
	^ self = OPUmlElementControllerTest
]

{ #category : 'accessing' }
OPUmlElementControllerTest >> diagramControllerClass [

	^ OPUmlPackageDiagramController
]

{ #category : 'accessing' }
OPUmlElementControllerTest >> diagramModelClass [

	^ OPUMLPackage
]
