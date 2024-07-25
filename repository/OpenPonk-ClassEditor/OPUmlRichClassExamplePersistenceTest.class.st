Class {
	#name : 'OPUmlRichClassExamplePersistenceTest',
	#superclass : 'OPExamplePersistenceTest',
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'hooks' }
OPUmlRichClassExamplePersistenceTest >> createExampleModel [

	^ OPUmlExamples exampleRichClass
]
