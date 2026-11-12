"
I am a testing utility responsible for generating backwards-compatibility test payloads specifically for legacy UML Class Diagram projects.
"
Class {
	#name : 'OPUmlLegacyProjectLoadTestGenerator',
	#superclass : 'OPLegacyProjectLoadTestGenerator',
	#category : 'OpenPonk-ClassEditor-Tests-UI',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'UI'
}

{ #category : 'hooks' }
OPUmlLegacyProjectLoadTestGenerator >> model [

	^ OPUmlExamples exampleSimpleAssociation
]
