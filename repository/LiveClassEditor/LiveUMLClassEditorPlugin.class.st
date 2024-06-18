Class {
	#name : 'LiveUMLClassEditorPlugin',
	#superclass : 'OPUmlClassPlugin',
	#category : 'LiveClassEditor-Plugin',
	#package : 'LiveClassEditor',
	#tag : 'Plugin'
}

{ #category : 'as yet unclassified' }
LiveUMLClassEditorPlugin >> diagramControllerClass [
	^ LUClassDiagramController
]

{ #category : 'as yet unclassified' }
LiveUMLClassEditorPlugin >> modelClass [
	^ OPUmlModel
]

{ #category : 'as yet unclassified' }
LiveUMLClassEditorPlugin >> name [
	^ 'Live Class Editor'
]
