Class {
	#name : 'OPUmlGeneralizationSetsExamplePersistenceTest',
	#superclass : 'OPExamplePersistenceTest',
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'hooks' }
OPUmlGeneralizationSetsExamplePersistenceTest >> createExampleModel [

	^ OPUmlExamples exampleGeneralizationSets
]
