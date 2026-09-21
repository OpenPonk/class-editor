Class {
	#name : 'OPUmlProfileController',
	#superclass : 'OPUmlPackageController',
	#traits : 'OPTUmlPackageableController',
	#classTraits : 'OPTUmlPackageableController classTrait',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'accessing' }
OPUmlProfileController class >> modelClass [
	^ OPUMLProfile
]

{ #category : 'accessing' }
OPUmlProfileController class >> viewModelClass [
	^ OPUmlProfileViewModel
]
