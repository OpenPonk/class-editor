"
Tests diagram controller interactions and canvas presentations for UML profile packages.
"
Class {
	#name : 'OPUmlProfileControllerTest',
	#superclass : 'OPUmlPackageControllerTest',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'accessing' }
OPUmlProfileControllerTest >> controllerClass [
	^ OPUmlProfileController
]

{ #category : 'accessing' }
OPUmlProfileControllerTest >> modelClass [
	^ OPUMLProfile
]
