Class {
	#name : 'OPUmlLegacyProjectLoadTestGenerator',
	#superclass : 'OPLegacyProjectLoadTestGenerator',
	#category : 'OpenPonk-ClassEditor-Tests - UI',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - UI'
}

{ #category : 'hooks' }
OPUmlLegacyProjectLoadTestGenerator >> model [

	^ OPUmlExamples exampleSimpleAssociation
]
