"
I am a unit test class verifying the configuration of OPUmlClassEditorPlugin, including its registered icon, model class, and diagram controller.
"
Class {
	#name : 'OPUmlClassEditorPluginTest',
	#superclass : 'TestCase',
	#instVars : [
		'plugin'
	],
	#category : 'OpenPonk-ClassEditor-Tests-Plugin',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Plugin'
}

{ #category : 'running' }
OPUmlClassEditorPluginTest >> setUp [
	super setUp.
	plugin := OPUmlClassEditorPlugin new
]

{ #category : 'tests' }
OPUmlClassEditorPluginTest >> testDefaultModelNameDefaultProfilesAndRepositoryName [

	self assert: plugin defaultModelName equals: 'UML Class Diagram'.
	self assertEmpty: OPUmlClassEditorPlugin defaultProfiles.
	self assert: OPUmlClassEditorPlugin repositoryName equals: #'class-editor'
]

{ #category : 'tests' }
OPUmlClassEditorPluginTest >> testDiagramControllerClass [

	self assert: plugin diagramControllerClass equals: OPUmlPackageDiagramController
]

{ #category : 'tests' }
OPUmlClassEditorPluginTest >> testExportPackagePassesSanitizedNameFallbackAndSerializerToDialog [

	| capturedBlock capturedFileName capturedExtensions capturedFilterName capturedTitle namedPackage blankPackage exportedXml |
	(OPExportFileDialog stub
		 exportBlock: Any
		 defaultFileName: Any
		 extensions: Any
		 named: Any
		 title: Any) will: [ :exportBlock :defaultFileName :extensions :filterName :dialogTitle |
			capturedBlock := exportBlock.
			capturedFileName := defaultFileName.
			capturedExtensions := extensions.
			capturedFilterName := filterName.
			capturedTitle := dialogTitle ].

	namedPackage := OPUMLPackage new name: 'Order / Model'.
	namedPackage packagedElements add: (OPUMLClass new name: 'Order').
	OPUmlClassEditorPlugin exportPackage: namedPackage.

	self assert: capturedFileName equals: (FileNameSanitizer sanitize: 'Order / Model') , '.xmi'.
	self assert: capturedExtensions equals: #( xmi xml uml ).
	self assert: capturedFilterName equals: 'XMI files'.
	self assert: capturedTitle equals: 'Choose a XMI file to export to'.
	exportedXml := capturedBlock value.
	self assert: (exportedXml includesSubstring: 'Order') description: 'Export block must serialize the package to XMI'.

	blankPackage := OPUMLPackage new name: '   '.
	OPUmlClassEditorPlugin exportPackage: blankPackage.
	self assert: capturedFileName equals: 'export.xmi'.

	OPUmlClassEditorPlugin exportPackage: Object new.
	self assert: capturedFileName equals: 'export.xmi'
]

{ #category : 'tests' }
OPUmlClassEditorPluginTest >> testIcon [

	self assert: plugin icon class equals: Form.
	self assert: plugin icon extent equals: OPUmlIcons packageIcon extent.
	self assert: plugin icon bits equals: OPUmlIcons packageIcon bits
]

{ #category : 'tests' }
OPUmlClassEditorPluginTest >> testImportToPackageImportsDirectAndNestedPackageFromXmi [

	| presenter directSourcePackage nestedRootPackage innerPackage targetPackage memoryFile okAction capturedNotification |
	presenter := StOpenFilePresenter new.
	StOpenFilePresenter stub new willReturn: presenter.
	presenter stub open willReturn: nil.

	targetPackage := OPUMLPackage new name: 'Target'.
	OPUmlClassEditorPlugin importToPackage: targetPackage.
	okAction := presenter instVarNamed: #okAction.

	directSourcePackage := OPUMLPackage new name: 'DirectSource'.
	directSourcePackage packagedElements
		add: (OPUMLClass new name: 'Alpha');
		add: (OPUMLClass new name: 'Beta').
	memoryFile := FileSystem memory / 'direct.xmi'.
	memoryFile writeStreamDo: [ :stream | stream << (OPUmlModelWithAltSpecURIsSerializer new serializeModel: directSourcePackage) ].

	[ okAction value: memoryFile ]
		on: InformativeNotification
		do: [ :notification | capturedNotification := notification messageText ].

	self assertCollection: (targetPackage packagedElements collect: #name) hasSameElements: #( 'Alpha' 'Beta' ).
	self
		assert: (capturedNotification includesSubstring: 'direct.xmi')
		description: 'Import must signal an informative notification with the file name'.

	nestedRootPackage := OPUMLPackage new name: 'OuterWrapper'.
	innerPackage := OPUMLPackage new name: 'InnerPackage'.
	innerPackage packagedElements add: (OPUMLClass new name: 'Gamma').
	nestedRootPackage packagedElements add: innerPackage.
	memoryFile := FileSystem memory / 'nested.xmi'.
	memoryFile writeStreamDo: [ :stream | stream << (OPUmlModelWithAltSpecURIsSerializer new serializeModel: nestedRootPackage) ].

	[ okAction value: memoryFile ]
		on: InformativeNotification
		do: [ :notification | capturedNotification := notification messageText ].

	self assertCollection: (targetPackage packagedElements collect: #name) hasSameElements: #( 'Gamma' )
]

{ #category : 'tests' }
OPUmlClassEditorPluginTest >> testIsForControllerRejectsWrongControllerClassAndAcceptsNilModel [

	| wrongController diagramController |
	wrongController := OPTestDiagramController new.
	self
		deny: (plugin isForController: wrongController)
		description: 'UML plugin must reject controllers of a different diagram controller class'.

	diagramController := OPUmlPackageDiagramController new.
	self
		assert: (plugin isForController: diagramController)
		description: 'Base UML plugin must accept its diagram controller even before a model is attached'
]

{ #category : 'tests' }
OPUmlClassEditorPluginTest >> testMergeModelsEmptyAndSingleModel [

	| singlePackage emptyMerged singleMerged |
	emptyMerged := plugin mergeModels: #(  ).
	self assert: emptyMerged class identicalTo: OPUMLPackage.

	singlePackage := OPUMLPackage new name: 'Solo'.
	singleMerged := plugin mergeModels: { singlePackage }.
	self assert: singleMerged identicalTo: singlePackage
]

{ #category : 'tests' }
OPUmlClassEditorPluginTest >> testMergeModelsPreservesFirstModelAsTargetAndMergesElementsAndProfiles [

	| firstPackage secondPackage thirdPackage classA classB classC profileA profileB merged reversedMerged otherFirst otherSecond |
	firstPackage := OPUMLPackage new name: 'First'.
	secondPackage := OPUMLPackage new name: 'Second'.
	thirdPackage := OPUMLPackage new name: 'Third'.
	classA := OPUMLClass new name: 'ClassA'.
	classB := OPUMLClass new name: 'ClassB'.
	classC := OPUMLClass new name: 'ClassC'.
	firstPackage packagedElements add: classA.
	secondPackage packagedElements add: classB.
	thirdPackage packagedElements add: classC.

	profileA := OPUMLProfile new name: 'ProfileA'.
	profileB := OPUMLProfile new name: 'ProfileB'.
	firstPackage profileApplications add: (OPUMLProfileApplication new appliedProfile: profileA).
	secondPackage profileApplications add: (OPUMLProfileApplication new appliedProfile: profileA).
	secondPackage profileApplications add: (OPUMLProfileApplication new appliedProfile: profileB).
	thirdPackage profileApplications add: (OPUMLProfileApplication new appliedProfile: profileB).

	merged := plugin mergeModels: {
			          firstPackage.
			          secondPackage.
			          thirdPackage.
			          firstPackage }.

	self assert: merged identicalTo: firstPackage.
	self assertCollection: (merged packagedElements collect: #name) hasSameElements: #( 'ClassA' 'ClassB' 'ClassC' ).
	self assert: classB owner identicalTo: firstPackage.
	self assert: classC owner identicalTo: firstPackage.
	self
		assertCollection: (merged profileApplications collect: [ :each | each appliedProfile name ])
		hasSameElements: #( 'ProfileA' 'ProfileB' ).

	otherFirst := OPUMLPackage new name: 'OtherFirst'.
	otherSecond := OPUMLPackage new name: 'OtherSecond'.
	reversedMerged := plugin mergeModels: {
			                  otherSecond.
			                  otherFirst }.
	self assert: reversedMerged identicalTo: otherSecond
]

{ #category : 'tests' }
OPUmlClassEditorPluginTest >> testModelClass [
	self assert: plugin modelClass equals: OPUMLPackage
]

{ #category : 'tests' }
OPUmlClassEditorPluginTest >> testName [
	self assert: plugin name equals: 'UML Class Editor'
]

{ #category : 'tests' }
OPUmlClassEditorPluginTest >> testNewModelContainsCommonTypesPackage [

	| model commonTypesPkg expectedTypeNames foundTypeNames |
	model := plugin newModel.
	commonTypesPkg := model packagedElements
		                  detect: [ :each | (each oclIsKindOf: #Package) and: [ each name = 'CommonTypes' ] ]
		                  ifNone: [ nil ].
	self assert: commonTypesPkg class equals: OPUMLPackage.
	self assert: commonTypesPkg name equals: 'CommonTypes'.
	expectedTypeNames := #( 'Date' 'DateTime' 'DateAndTime' 'Time' 'Timestamp' 'Duration' 'Decimal' 'Float' 'Double' 'Long' 'Number'
	                        'Char' 'Text' 'Clob' 'Byte' 'ByteArray' 'Blob' 'UUID' 'URI' 'URL' 'Email' 'JSON' 'XML' ).
	foundTypeNames := (commonTypesPkg packagedElements select: [ :each | each oclIsKindOf: #DataType ] thenCollect: #name) asSet.
	self assertCollection: foundTypeNames includesAll: expectedTypeNames
]

{ #category : 'tests' }
OPUmlClassEditorPluginTest >> testPluginRegistrySelectsUmlClassEditorPluginForPlainAndCustomProfileModels [

	| plainPackage customProfile customPackage project projectController diagramController |
	plainPackage := plugin newModel.
	self assert: (OPPluginRegistry default pluginFor: plainPackage) class identicalTo: OPUmlClassEditorPlugin.

	project := OPProject named: 'Plain UML Test'.
	project addModel: plainPackage.
	projectController := OPProjectController forProject: project.
	diagramController := OPUmlPackageDiagramController new.
	projectController addDiagramController: diagramController.
	diagramController model: plainPackage.
	self assert: (OPPluginRegistry default pluginForController: diagramController) class identicalTo: OPUmlClassEditorPlugin.

	customProfile := OPUMLProfile new
		                 name: 'CustomProfile';
		                 URI: 'http://example.org/custom';
		                 yourself.
	customPackage := OPUMLPackage new name: 'CustomModel'.
	customPackage profileApplications add: (OPUMLProfileApplication new
			 appliedProfile: customProfile;
			 yourself).
	self assert: (OPPluginRegistry default pluginFor: customPackage) class identicalTo: OPUmlClassEditorPlugin
]

{ #category : 'tests' }
OPUmlClassEditorPluginTest >> testSpecializedPluginDoesNotMatchPlainModelOrUnrelatedNilUriProfile [

	| requiredProfile unrelatedNilUriProfile uriProfile matchingUriProfile specializedClass specializedPlugin plainPackage nilUriPackage matchingPackage matchingUriPackage project projectController diagramController |
	requiredProfile := OPUMLProfile new name: 'RequiredProfile'.
	unrelatedNilUriProfile := OPUMLProfile new name: 'OtherNilUriProfile'.
	uriProfile := OPUMLProfile new
		              name: 'UriProfile';
		              URI: 'http://example.org/specialized';
		              yourself.
	matchingUriProfile := OPUMLProfile new
		                      name: 'UriProfileCopy';
		                      URI: 'http://example.org/specialized';
		                      yourself.

	specializedClass := OPUmlClassEditorPlugin newAnonymousSubclass.
	specializedClass stub defaultProfiles willReturn: { requiredProfile }.
	specializedPlugin := specializedClass new.

	plainPackage := OPUMLPackage new name: 'Plain'.
	self
		deny: (specializedPlugin supportsProfilesOf: plainPackage)
		description: 'Specialized plugin with defaultProfiles must not match a plain package without applied profiles'.

	project := OPProject named: 'Specialized Test'.
	project addModel: plainPackage.
	projectController := OPProjectController forProject: project.
	diagramController := OPUmlPackageDiagramController new.
	projectController addDiagramController: diagramController.
	diagramController model: plainPackage.
	self
		deny: (specializedPlugin isForController: diagramController)
		description: 'Specialized plugin must not claim controller of a plain package'.

	nilUriPackage := OPUMLPackage new name: 'UnrelatedNilUri'.
	nilUriPackage profileApplications add: (OPUMLProfileApplication new
			 appliedProfile: unrelatedNilUriProfile;
			 yourself).
	self
		deny: (specializedPlugin supportsProfilesOf: nilUriPackage)
		description: 'Two distinct profiles with nil URI must not falsely match'.

	matchingPackage := OPUMLPackage new name: 'MatchingByIdentity'.
	matchingPackage profileApplications add: (OPUMLProfileApplication new
			 appliedProfile: requiredProfile;
			 yourself).
	self
		assert: (specializedPlugin supportsProfilesOf: matchingPackage)
		description: 'Specialized plugin must match package applying its default profile by identity'.

	specializedClass stub defaultProfiles willReturn: { uriProfile }.
	matchingUriPackage := OPUMLPackage new name: 'MatchingByUri'.
	matchingUriPackage profileApplications add: (OPUMLProfileApplication new
			 appliedProfile: matchingUriProfile;
			 yourself).
	self
		assert: (specializedPlugin supportsProfilesOf: matchingUriPackage)
		description: 'Specialized plugin must match package applying a profile with the same non-nil URI'
]

{ #category : 'tests' }
OPUmlClassEditorPluginTest >> testSupportsProfilesOfCustomProfileReturnsTrue [

	| customProfile customPackage |
	customProfile := OPUMLProfile new
		                 name: 'CustomProfile';
		                 URI: 'http://example.org/custom';
		                 yourself.
	customPackage := OPUMLPackage new name: 'CustomModel'.
	customPackage profileApplications add: (OPUMLProfileApplication new
			 appliedProfile: customProfile;
			 yourself).
	self
		assert: (plugin supportsProfilesOf: customPackage)
		description: 'Base UML Class Editor plugin must support packages with custom profiles not claimed by specialized plugins'.
	self
		assert: (plugin isPluginFor: customPackage)
		description: 'Base UML Class Editor plugin must be a plugin for packages with custom profiles'
]
