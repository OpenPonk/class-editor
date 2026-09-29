"
Verifies the serialization and deserialization roundtrip persistence for UML class models and diagrams.
"
Class {
	#name : 'OPUmlClassEditorPluginRoundtripTest',
	#superclass : 'OPAbstractPluginExampleRoundtripTest',
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPUmlClassEditorPluginRoundtripTest class >> pluginClass [
	^ OPUmlClassEditorPlugin
]
