"
I serialize UML models into XMI, and the diagrams into STON.
"
Class {
	#name : #OPUmlModelSerializer,
	#superclass : #OPModelSerializer,
	#category : #'OpenPonk-ClassEditor-Persistence'
}

{ #category : #accessing }
OPUmlModelSerializer >> formatName [
	^ 'xmi'
]

{ #category : #accessing }
OPUmlModelSerializer >> materializeModelFrom: aString [
	^ OPUMLXMIReader read: aString
]

{ #category : #accessing }
OPUmlModelSerializer >> serializeModel: aModel [
	^ OPUMLXMIWriter toString: aModel
]
