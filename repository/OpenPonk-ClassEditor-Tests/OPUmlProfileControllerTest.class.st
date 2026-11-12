"
Tests diagram controller interactions and canvas presentations for UML profile packages.
"
Class {
	#name : 'OPUmlProfileControllerTest',
	#superclass : 'OPUmlPackageControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests-Profiles',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Profiles'
}

{ #category : 'accessing' }
OPUmlProfileControllerTest >> controllerClass [
	^ OPUmlProfileController
]

{ #category : 'accessing' }
OPUmlProfileControllerTest >> modelClass [
	^ OPUMLProfile
]
