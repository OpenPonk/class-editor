"
I am an integration test class verifying that the UML Rich Class example model safely survives a roundtrip serialization process (save and load).
"
Class {
	#name : 'OPUmlRichClassExamplePersistenceTest',
	#superclass : 'OPExamplePersistenceTest',
	#category : 'OpenPonk-ClassEditor-Tests-Examples',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Examples'
}

{ #category : 'hooks' }
OPUmlRichClassExamplePersistenceTest >> createExampleModel [

	^ OPUmlExamples exampleRichClass
]
