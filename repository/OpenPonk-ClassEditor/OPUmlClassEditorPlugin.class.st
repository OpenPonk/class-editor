"
I am a plugin for UML Class Diagram
"
Class {
	#name : #OPUmlClassEditorPlugin,
	#superclass : #OPPlugin,
	#category : #'OpenPonk-ClassEditor-Plugin'
}

{ #category : #'as yet unclassified' }
OPUmlClassEditorPlugin class >> allDefaultProfiles [

	^ self withAllSubclasses flatCollectAsSet: #defaultProfiles
]

{ #category : #'as yet unclassified' }
OPUmlClassEditorPlugin class >> defaultProfiles [
	^ {}
]

{ #category : #toolbar }
OPUmlClassEditorPlugin class >> exportPackage: aPackage [

	StFBSaveFileDialog new
		title: 'Choose a XMI file to export to';
		okAction: [ :file | 
			file
				ensureDelete;
				writeStreamDo: [ :stream | 
					stream << (OPUMLXMIWriter toString: aPackage) ].
			self inform: 'Exported to ' , file fullName ];
		extensions: #( xmi xml uml ) named: 'XMI files';
		open
]

{ #category : #toolbar }
OPUmlClassEditorPlugin class >> importToPackage: aPackage [

	StFBOpenFileDialog new
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

{ #category : #'as yet unclassified' }
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

{ #category : #testing }
OPUmlClassEditorPlugin >> supportsMergingModels [
	^ true
]
