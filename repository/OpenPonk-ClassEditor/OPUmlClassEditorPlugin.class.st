"
I am a plugin for UML Class Diagram
"
Class {
	#name : #OPUmlClassEditorPlugin,
	#superclass : #OPPlugin,
	#category : #'OpenPonk-ClassEditor-Plugin'
}

{ #category : #'as yet unclassified' }
OPUmlClassEditorPlugin class >> defaultProfiles [
	^ {}
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

{ #category : #'as yet unclassified' }
OPUmlClassEditorPlugin >> defaultProfiles [
	^ self class defaultProfiles
]

{ #category : #accessing }
OPUmlClassEditorPlugin >> diagramControllerClass [
	^ OPUmlPackageDiagramController
]

{ #category : #accessing }
OPUmlClassEditorPlugin >> icon [
	^ OPUmlIcons packageIcon
]

{ #category : #testing }
OPUmlClassEditorPlugin >> isForController: aDiagramController [
	| appliedProfiles pluginClassesWithProfileCounts |
	appliedProfiles := aDiagramController model
		ifNil: [ {} ]
		ifNotNil: [ :model | model profileApplications collect: #appliedProfile ].
	pluginClassesWithProfileCounts := (self class withAllSubclasses
		collect: [ :eachPluginClass | 
			eachPluginClass
				->
					(eachPluginClass defaultProfiles
						count: [ :eachDefaultPlugin | appliedProfiles includes: eachDefaultPlugin ]) ])
		sorted: [ :a :b | a value > b value ].
	^ pluginClassesWithProfileCounts first value isZero
		or: [ pluginClassesWithProfileCounts first key = self class ]
]

{ #category : #accessing }
OPUmlClassEditorPlugin >> isPluginFor: aModel [
	^ {self modelClass.
	OPUMLModel.
	OPUMLProfile} includes: aModel class
]

{ #category : #'as yet unclassified' }
OPUmlClassEditorPlugin >> layouterClass [
	^ OPUmlLayouter
]

{ #category : #accessing }
OPUmlClassEditorPlugin >> modelClass [
	^ OPUMLPackage
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
