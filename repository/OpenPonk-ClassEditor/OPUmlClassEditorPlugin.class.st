"
I am the core plugin for the OpenPonk UML Class Diagram editor. I register the necessary controllers, serializers, layouters, and default profiles (like standard UML primitive types) into the OpenPonk environment.
"
Class {
	#name : 'OPUmlClassEditorPlugin',
	#superclass : 'OPPlugin',
	#category : 'OpenPonk-ClassEditor-Plugin',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Plugin'
}

{ #category : 'accessing' }
OPUmlClassEditorPlugin class >> defaultProfiles [
	^ {}
]

{ #category : 'exporting' }
OPUmlClassEditorPlugin class >> exportPackage: aPackage [
	| baseName |
	baseName := (aPackage respondsTo: #name)
		ifTrue: [ aPackage name ]
		ifFalse: [ nil ].
	(baseName isNil or: [ baseName trimBoth isEmpty ]) ifTrue: [ baseName := 'export' ].
	OPExportFileDialog
		exportBlock: [ OPUmlModelWithAltSpecURIsSerializer new serializeModel: aPackage ]
		defaultFileName: (FileNameSanitizer sanitize: baseName trimBoth) , '.xmi'
		extensions: #( xmi xml uml )
		named: 'XMI files'
		title: 'Choose a XMI file to export to'
]

{ #category : 'toolbar' }
OPUmlClassEditorPlugin class >> importToPackage: aPackage [

	StOpenFilePresenter new
		title: 'Choose a XMI export of UML model';
		okAction: [ :file |
				| model |
				model := OPUMLXMIReader read: file contents.
				(model packagedElements size = 1 and: [ model packagedElements first oclIsKindOf: #Package ]) ifTrue: [
						model := model packagedElements first ].
				aPackage packagedElements: model packagedElements.
				InformativeNotification signal: 'Imported from ' , file fullName ];
		extensions: #( xmi xml uml ) named: 'XMI files';
		open
]

{ #category : 'accessing' }
OPUmlClassEditorPlugin class >> repositoryName [
	^ #'class-editor'
]

{ #category : 'accessing' }
OPUmlClassEditorPlugin >> defaultModelName [

	^ 'UML Class Diagram'
]

{ #category : 'accessing' }
OPUmlClassEditorPlugin >> defaultProfiles [
	^ self class defaultProfiles
]

{ #category : 'accessing' }
OPUmlClassEditorPlugin >> diagramControllerClass [
	^ OPUmlPackageDiagramController
]

{ #category : 'templates' }
OPUmlClassEditorPlugin >> exampleProjectTemplates [
	"Answers example project templates for UML class diagrams."

	^ { 
		(OPProjectTemplate
			named: 'Generalization Sets'
			icon: self icon
			modelFactory: [ OPUmlExamples exampleGeneralizationSets ]
			isExample: true).
		(OPProjectTemplate
			named: 'Rich Class'
			icon: self icon
			modelFactory: [ OPUmlExamples exampleRichClass ]
			isExample: true).
		(OPProjectTemplate
			named: 'Simple Association'
			icon: self icon
			modelFactory: [ OPUmlExamples exampleSimpleAssociation ]
			isExample: true).
		(OPProjectTemplate
			named: 'Simple Generalization'
			icon: self icon
			modelFactory: [ OPUmlExamples exampleSimpleGeneralization ]
			isExample: true).
		(OPProjectTemplate
			named: 'Package Architecture'
			icon: self icon
			modelFactory: [ OPUmlExamples examplePackageArchitecture ]
			isExample: true).
		(OPProjectTemplate
			named: 'Security Profile'
			icon: self icon
			modelFactory: [ OPUmlExamples exampleSecurityProfile ]
			isExample: true) }
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
	^ OPUmlModelWithAltSpecURIsSerializer
]

{ #category : 'accessing' }
OPUmlClassEditorPlugin >> name [
	^ 'UML Class Editor'
]

{ #category : 'instance creation' }
OPUmlClassEditorPlugin >> newModel [
	| model |
	model := super newModel.
	model packagedElements add: OPUmlCommonTypesFactory new commonTypesPackage.
	^ model
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
