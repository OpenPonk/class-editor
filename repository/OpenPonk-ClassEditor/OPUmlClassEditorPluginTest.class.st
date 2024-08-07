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
