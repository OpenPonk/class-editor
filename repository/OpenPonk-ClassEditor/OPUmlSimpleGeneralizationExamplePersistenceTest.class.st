"
I am an integration test class verifying that the UML Simple Generalization example model safely survives a roundtrip serialization process (save and load).
"
Class {
	#name : 'OPUmlSimpleGeneralizationExamplePersistenceTest',
	#superclass : 'OPExamplePersistenceTest',
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'hooks' }
OPUmlSimpleGeneralizationExamplePersistenceTest >> createExampleModel [

	^ OPUmlExamples exampleSimpleGeneralization
]
