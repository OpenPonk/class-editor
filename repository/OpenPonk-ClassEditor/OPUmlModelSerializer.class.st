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
OPUmlModelSerializer >> materializeModelFrom: aStream [
	^ OPUMLXMIReader read: aStream
]

{ #category : #accessing }
OPUmlModelSerializer >> serializeModel: aModel [
	^ OPUMLXMIWriter toString: aModel
]

{ #category : #accessing }
OPUmlModelSerializer >> serializeModel: aModel to: aStream [
	^ aStream << (self serializeModel: aModel)
]
