"
I am a plugin for UML Class Diagram
"
Class {
	#name : 'OPUmlClassEditorPlugin',
	#superclass : 'OPPlugin',
	#category : 'OpenPonk-ClassEditor-Plugin',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Plugin'
}

{ #category : 'as yet unclassified' }
OPUmlClassEditorPlugin class >> defaultProfiles [
	^ {}
]

{ #category : 'toolbar' }
OPUmlClassEditorPlugin class >> exportPackage: aPackage [

	StSaveFilePresenter new
		title: 'Choose a XMI file to export to';
		okAction: [ :file | 
			file
				ensureDelete;
				writeStreamDo: [ :stream | 
					stream << (OPUmlModelSerializer new serializeModel: aPackage) ].
			UIManager default
				inform: (String streamContents: [ :s | 
						 s << 'Exported to ' << file pathString.
						 s
							 cr;
							 cr.
						 s << 'Click to open location' ])
				actionOnClick: [ file openInOSFileBrowser ] ];
		extensions: #( xmi xml uml ) named: 'XMI files';
		open
]

{ #category : 'toolbar' }
OPUmlClassEditorPlugin class >> importToPackage: aPackage [

	StOpenFilePresenter new
		title: 'Choose a XMI export of UML model';
		okAction: [ :file | 
			| model |
			model := OPUMLXMIReader read: file contents.
			(model packagedElements size = 1 and: [ 
					 model packagedElements first oclIsKindOf: #Package ]) ifTrue: [ 
					model := model packagedElements first ].
			aPackage packagedElements: model packagedElements.
			self inform: 'Imported from ' , file fullName ];
		extensions: #( xmi xml uml ) named: 'XMI files';
		open
]

{ #category : 'accessing' }
OPUmlClassEditorPlugin >> defaultProfiles [
	^ self class defaultProfiles
]

{ #category : 'accessing' }
OPUmlClassEditorPlugin >> diagramControllerClass [
	^ OPUmlPackageDiagramController
]

{ #category : 'accessing' }
OPUmlClassEditorPlugin >> icon [
	^ OPUmlIcons packageIcon
]

{ #category : 'testing' }
OPUmlClassEditorPlugin >> isForController: aDiagramController [

	| appliedProfiles pluginClassesWithProfileCounts |
	(super isForController: aDiagramController) ifFalse: [ ^ false ].
	appliedProfiles := aDiagramController model
		                   ifNil: [ #(  ) ]
		                   ifNotNil: [ :model |
		                   model profileApplications collect:
			                   #appliedProfile ].
	(appliedProfiles isEmpty and: [ self defaultProfiles isEmpty ])
		ifTrue: [ ^ true ].
	pluginClassesWithProfileCounts := (self class withAllSubclasses
		                                   collect: [ :eachPluginClass |
				                                   eachPluginClass
				                                   ->
					                                   (eachPluginClass
						                                    defaultProfiles count: [
						                                    :eachDefaultPlugin |
						                                    appliedProfiles includes:
							                                    eachDefaultPlugin ]) ])
		                                  sorted: [ :a :b |
		                                  a value > b value ].
	^ pluginClassesWithProfileCounts first value isZero or: [
		  pluginClassesWithProfileCounts first key = self class ]
]

{ #category : 'testing' }
OPUmlClassEditorPlugin >> isPluginFor: aModel [

	^ ({ 
		   self modelClass.
		   OPUMLProfile } includes: aModel class) and: [ 
		  self supportsProfilesOf: aModel ]
]

{ #category : 'accessing' }
OPUmlClassEditorPlugin >> layouterClass [
	^ OPUmlLayouter
]

{ #category : 'model updates' }
OPUmlClassEditorPlugin >> mergeModels: aModelsCollection [

	| models targetModel otherModels |
	models := aModelsCollection asSet asArray.
	aModelsCollection ifEmpty: [ ^ OPUMLPackage new ].
	aModelsCollection size = 1 ifTrue: [ ^ aModelsCollection anyOne ].
	targetModel := models first.
	otherModels := models copyWithoutFirst.
	(otherModels flatCollect: [ :eachModel | 
		 eachModel profileApplications ])
		reject: [ :eachProfileApplication | 
			targetModel profileApplications anySatisfy: [ 
				:anyTargetProfileApplication | 
				anyTargetProfileApplication appliedProfile name
				= eachProfileApplication appliedProfile name ] ]
		thenDo: [ :eachProfileApplication | 
			targetModel profileApplications add: (OPUMLProfileApplication new
					 uuid: eachProfileApplication uuid;
					 appliedProfile: eachProfileApplication appliedProfile) ].
	otherModels do: [ :eachModel | 
		eachModel packagedElements do: [ :eachElement | 
			eachElement owner: targetModel.
			targetModel packagedElements add: eachElement ] ].
	^ targetModel
]

{ #category : 'accessing' }
OPUmlClassEditorPlugin >> modelClass [
	^ OPUMLPackage
]

{ #category : 'accessing' }
OPUmlClassEditorPlugin >> modelSerializerClass [
	^ OPUmlModelSerializer
]

{ #category : 'accessing' }
OPUmlClassEditorPlugin >> name [
	^ 'UML Class Editor'
]

{ #category : 'testing' }
OPUmlClassEditorPlugin >> supportsHidingElements [
	^ true
]

{ #category : 'testing' }
OPUmlClassEditorPlugin >> supportsMergingModels [
	^ true
]

{ #category : 'testing' }
OPUmlClassEditorPlugin >> supportsProfilesOf: aModel [

	^ aModel profileApplications allSatisfy: [ :each | 
		  self defaultProfiles includes: each appliedProfile ]
]
