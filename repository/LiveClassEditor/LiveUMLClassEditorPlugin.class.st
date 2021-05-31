Class {
	#name : #LiveUMLClassEditorPlugin,
	#superclass : #OPUmlClassPlugin,
	#category : 'LiveClassEditor-Plugin'
}

{ #category : #'as yet unclassified' }
LiveUMLClassEditorPlugin >> diagramControllerClass [
	^ LUClassDiagramController
]

{ #category : #'as yet unclassified' }
LiveUMLClassEditorPlugin >> modelClass [
	^ OPUMLModel
]

{ #category : #'as yet unclassified' }
LiveUMLClassEditorPlugin >> name [
	^ 'Live Class Editor'
]
