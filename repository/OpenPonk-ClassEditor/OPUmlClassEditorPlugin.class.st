"
I am a plugin for UML Class Diagram
"
Class {
	#name : #OPUmlClassEditorPlugin,
	#superclass : #OPPlugin,
	#category : #'OpenPonk-ClassEditor-Plugin'
}

{ #category : #toolbar }
OPUmlClassEditorPlugin class >> exportPackage: aPackage [
	FDSaveFileDialog new
		whenSelected: [ :file | 
			file
				ensureDelete;
				writeStreamDo: [ :stream | stream << (OPUMLXMIWriter toString: aPackage) ].
			self inform: 'Exported to ' , file fullName ];
		extensionFilters:
			{'XMI files' -> #(xmi xml uml).
			'All files' -> #()};
		defaultFolder: FileLocator imageDirectory asFileReference;
		open
]

{ #category : #toolbar }
OPUmlClassEditorPlugin class >> importToPackage: aPackage [
	FDOpenFileDialog new
		whenSelected: [ :file | 
			| model |
			model := OPUMLXMIReader read: file contents.
			(model packagedElements size = 1
				and: [ model packagedElements first oclIsKindOf: #Package ])
				ifTrue: [ model := model packagedElements first ].
			aPackage packagedElements: model packagedElements.
			self inform: 'Imported from ' , file fullName ];
		extensionFilters:
			{('XMI files' -> #(xmi xml uml)).
			('All files' -> #())};
		defaultFolder: FileLocator imageDirectory asFileReference;
		open
]

{ #category : #accessing }
OPUmlClassEditorPlugin >> diagramControllerClass [
	^ OPUmlPackageDiagramController
]

{ #category : #accessing }
OPUmlClassEditorPlugin >> icon [
	^ OPUmlIcons packageIcon
]

{ #category : #accessing }
OPUmlClassEditorPlugin >> isPluginFor: aModel [
	^ aModel class = self modelClass | (aModel class = OPUMLPackage) | (aModel class = OPUMLProfile)
]

{ #category : #'as yet unclassified' }
OPUmlClassEditorPlugin >> layouterClass [
	^ OPUmlLayouter
]

{ #category : #accessing }
OPUmlClassEditorPlugin >> modelClass [
	^ OPUMLModel
]

{ #category : #accessing }
OPUmlClassEditorPlugin >> modelSerializerClass [
	^ OPUmlModelSerializer
]

{ #category : #accessing }
OPUmlClassEditorPlugin >> name [
	^ 'UML Class Editor'
]

{ #category : #'as yet unclassified' }
OPUmlClassEditorPlugin >> supportsHidingElements [
	^ true
]
