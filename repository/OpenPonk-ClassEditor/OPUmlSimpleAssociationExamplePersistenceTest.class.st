"
I am an integration test class verifying that the UML Simple Association example model safely survives a roundtrip serialization process (save and load).
"
Class {
	#name : 'OPUmlSimpleAssociationExamplePersistenceTest',
	#superclass : 'OPExamplePersistenceTest',
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'hooks' }
OPUmlSimpleAssociationExamplePersistenceTest >> createExampleModel [

	^ OPUmlExamples exampleSimpleAssociation
]
