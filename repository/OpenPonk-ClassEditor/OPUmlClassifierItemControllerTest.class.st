Class {
	#name : 'OPUmlClassifierItemControllerTest',
	#superclass : 'OPUmlElementControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'testing' }
OPUmlClassifierItemControllerTest class >> isAbstract [

	^ self = OPUmlClassifierItemControllerTest
]

{ #category : 'accessing' }
OPUmlClassifierItemControllerTest >> creationTargetControllerClass [

	^ OPUmlClassController
]

{ #category : 'accessing' }
OPUmlClassifierItemControllerTest >> creationTargetModelClass [

	^ OPUMLClass
]
