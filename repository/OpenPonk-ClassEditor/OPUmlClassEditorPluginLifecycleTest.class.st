"
Verifies the lifecycle, registration, and dependency resolution of the UML Class Editor plugin.
"
Class {
	#name : 'OPUmlClassEditorPluginLifecycleTest',
	#superclass : 'OPAbstractPluginExampleLifecycleTest',
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPUmlClassEditorPluginLifecycleTest class >> pluginClass [
	"Answers the OPPlugin class under test."
	^ OPUmlClassEditorPlugin
]
