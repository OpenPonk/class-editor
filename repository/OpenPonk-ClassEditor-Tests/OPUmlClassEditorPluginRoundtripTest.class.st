"
Verifies the serialization and deserialization roundtrip persistence for UML class models and diagrams.
"
Class {
	#name : 'OPUmlClassEditorPluginRoundtripTest',
	#superclass : 'OPAbstractPluginExampleRoundtripTest',
	#category : 'OpenPonk-ClassEditor-Tests-Plugin',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Plugin'
}

{ #category : 'accessing' }
OPUmlClassEditorPluginRoundtripTest class >> pluginClass [
	^ OPUmlClassEditorPlugin
]
