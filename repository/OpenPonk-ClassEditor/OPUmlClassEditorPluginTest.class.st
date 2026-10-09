"
I am a unit test class verifying the configuration of OPUmlClassEditorPlugin, including its registered icon, model class, and diagram controller.
"
Class {
	#name : 'OPUmlClassEditorPluginTest',
	#superclass : 'TestCase',
	#instVars : [
		'plugin'
	],
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
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
	self assert: plugin icon isForm
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
	| plugin model commonTypesPkg expectedTypeNames foundTypeNames |
	plugin := OPUmlClassEditorPlugin new.
	model := plugin newModel.
	commonTypesPkg := model packagedElements
		detect: [ :each | (each oclIsKindOf: #Package) and: [ each name = 'CommonTypes' ] ]
		ifNone: [ nil ].
	self assert: commonTypesPkg isNotNil description: 'Model must contain CommonTypes package'.
	expectedTypeNames := #(
		'Date' 'DateTime' 'DateAndTime' 'Time' 'Timestamp' 'Duration'
		'Decimal' 'Float' 'Double' 'Long' 'Number'
		'Char' 'Text' 'Clob'
		'Byte' 'ByteArray' 'Blob'
		'UUID' 'URI' 'URL' 'Email'
		'JSON' 'XML'
	).
	foundTypeNames := (commonTypesPkg packagedElements
		select: [ :each | each oclIsKindOf: #DataType ]
		thenCollect: #name) asSet.
	self assertCollection: foundTypeNames includesAll: expectedTypeNames
]
