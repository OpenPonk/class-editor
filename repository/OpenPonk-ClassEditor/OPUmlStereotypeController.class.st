"
I am a controller for a Stereotype.
"
Class {
	#name : #OPUmlStereotypeController,
	#superclass : #OPUmlClassController,
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #accessing }
OPUmlStereotypeController >> modelClass [
	^ OPUMLStereotype
]

{ #category : #accessing }
OPUmlStereotypeController >> modelClassName [
	^ #Stereotype
]

{ #category : #accessing }
OPUmlStereotypeController >> stereotypeNames [
	^ #(stereotype)
]
