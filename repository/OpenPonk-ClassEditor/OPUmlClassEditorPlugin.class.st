"
I am a plugin for UML Class Diagram
"
Class {
	#name : #OPUmlClassEditorPlugin,
	#superclass : #OPPlugin,
	#category : #'OpenPonk-ClassEditor-Plugin'
}

{ #category : #toolbar }
OPUmlClassEditorPlugin class >> addModelTo: aProject [
	
]

{ #category : #toolbar }
OPUmlClassEditorPlugin class >> canvasToolbarFor: aBuilder [
	<opCanvasToolbar: #OPUmlClassEditorPlugin>
	(aBuilder item: 'Layout') action: [  ].
	aBuilder model diagramController addLayoutMenu: aBuilder parent: 'Layout'
]

{ #category : #toolbar }
OPUmlClassEditorPlugin class >> contextMenu: aBuilder [
	<opModelNavigatorContextMenu: #OPUmlClassEditorPlugin>
	| navigator selectedItem |
	navigator := aBuilder model.
	selectedItem := navigator selectedItem.
	(selectedItem oclIsKindOf: #Package)
		ifTrue: [ (aBuilder item: 'Export as XMI...') action: [ self exportPackage: selectedItem ].
			(aBuilder item: 'Import from XMI...') action: [ self importToPackage: selectedItem ] ]
]

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
		whenSelected: [ :file | |model|
			model := OPUMLXMIReader read: file contents.
			self inform: 'Imported from ' , file fullName ];
		extensionFilters:
			{'XMI files' -> #(xmi xml uml).
			'All files' -> #()};
		defaultFolder: FileLocator imageDirectory asFileReference;
		open
]

{ #category : #toolbar }
OPUmlClassEditorPlugin class >> toolbarMenu: aBuilder [
	"<opEditorToolbarMenu: #OPUmlOldClassPlugin>
	(aBuilder item: 'DSL Editor')
		action: [ OPDslEditor new
				parser: OPUmlDslParser new;
				exporter: OPUmlDslExporter new;
				modelClass: MooseModel;
				model: aBuilder model diagramController model;
				openWithSpec ]"
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

{ #category : #accessing }
OPUmlClassEditorPlugin >> modelClass [
	^ OPUMLModel
]

{ #category : #accessing }
OPUmlClassEditorPlugin >> name [
	^ 'UML Class Editor'
]

{ #category : #accessing }
OPUmlClassEditorPlugin >> serializerClass [
	^ OPUmlSerializer
]

{ #category : #'as yet unclassified' }
OPUmlClassEditorPlugin >> supportsHidingElements [
	^ true
]
