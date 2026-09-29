"
I am an abstract base test class verifying the behavior of controllers for items inside classifiers (like attributes and operations), ensuring they attach to the correct target model controllers.
"
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

{ #category : 'constants' }
OPUmlClassifierItemControllerTest >> creationTargetControllerClass [

	^ OPUmlClassController
]

{ #category : 'constants' }
OPUmlClassifierItemControllerTest >> creationTargetModelClass [

	^ OPUMLClass
]
