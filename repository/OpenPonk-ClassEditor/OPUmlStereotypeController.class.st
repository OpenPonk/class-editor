"
I am the controller for UML Stereotypes within a profile diagram. I extend standard class controller behavior to handle the unique visual and structural rules of defining stereotypes.
"
Class {
	#name : 'OPUmlStereotypeController',
	#superclass : 'OPUmlClassController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPUmlStereotypeController class >> diagramElementClass [

	^ OPUmlStereotypeShape
]

{ #category : 'accessing' }
OPUmlStereotypeController class >> viewModelClass [
	^ OPUmlStereotypeViewModel
]
