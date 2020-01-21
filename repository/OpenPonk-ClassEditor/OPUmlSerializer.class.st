"
I serialize UML models into XMI, and the diagrams into STON.
"
Class {
	#name : #OPUmlSerializer,
	#superclass : #OPAbstractSerializer,
	#category : 'OpenPonk-ClassEditor-Persistence'
}

{ #category : #accessing }
OPUmlSerializer >> diagramExtension [
	^ 'ston'
]

{ #category : #accessing }
OPUmlSerializer >> materializeDiagramFrom: aString [
	^ OPStonSerializer new materializeDiagramFrom: aString
]

{ #category : #accessing }
OPUmlSerializer >> materializeModelFrom: aString [
	^ OPUMLXMIReader read: aString
]

{ #category : #accessing }
OPUmlSerializer >> modelExtension [
	^ 'xmi'
]

{ #category : #accessing }
OPUmlSerializer >> serializeDiagram: aDiagramMemento [
	^ OPStonSerializer new serializeDiagram: aDiagramMemento
]

{ #category : #accessing }
OPUmlSerializer >> serializeModel: aModel [
	^ OPUMLXMIWriter toString: aModel
]
