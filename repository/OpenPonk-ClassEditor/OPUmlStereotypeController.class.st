"
I am a controller for a Stereotype.
"
Class {
	#name : #OPUmlStereotypeController,
	#superclass : #OPUmlClassController,
	#category : 'OpenPonk-ClassEditor-Controllers'
}

{ #category : #model }
OPUmlStereotypeController >> createModel [
	^ self modelClass new
		name: 'Stereotype';
		yourself
]

{ #category : #accessing }
OPUmlStereotypeController >> modelClass [
	^ OPUMLStereotype
]

{ #category : #accessing }
OPUmlStereotypeController >> stereotypeNames [
	^ #(stereotype)
]
