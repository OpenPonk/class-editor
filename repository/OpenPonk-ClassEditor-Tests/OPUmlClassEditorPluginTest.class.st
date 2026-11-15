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
OPUmlClassEditorPluginTest >> testDiagramControlllerClass [
	self assert: plugin diagramControllerClass equals: OPUmlPackageDiagramController
]

{ #category : 'tests' }
OPUmlClassEditorPluginTest >> testIcon [

	self assert: plugin icon class equals: Form.
	self assert: plugin icon extent equals: OPUmlIcons packageIcon extent.
	self assert: plugin icon bits equals: OPUmlIcons packageIcon bits
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
