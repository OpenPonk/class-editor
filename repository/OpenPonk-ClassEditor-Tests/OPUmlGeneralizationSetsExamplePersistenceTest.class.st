"
I am an integration test class verifying that the UML Generalization Sets example model safely survives a roundtrip serialization process (save and load).
"
Class {
	#name : 'OPUmlGeneralizationSetsExamplePersistenceTest',
	#superclass : 'OPExamplePersistenceTest',
	#category : 'OpenPonk-ClassEditor-Tests-Examples',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Examples'
}

{ #category : 'hooks' }
OPUmlGeneralizationSetsExamplePersistenceTest >> createExampleModel [

	^ OPUmlExamples exampleGeneralizationSets
]
