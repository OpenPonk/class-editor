"
I am a controller for a Stereotype.
"
Class {
	#name : 'OPUmlStereotypeController',
	#superclass : 'OPUmlClassController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPUmlStereotypeController >> diagramElementClass [

	^ OPUmlStereotypeShape
]

{ #category : 'accessing' }
OPUmlStereotypeController >> modelClass [
	^ OPUMLStereotype
]

{ #category : 'accessing' }
OPUmlStereotypeController >> modelClassName [

	^ 'Stereotype'
]
