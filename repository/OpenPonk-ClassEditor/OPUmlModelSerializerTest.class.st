"
An OPUmlSerializerTest is a test class for testing the behavior of OPUmlSerializer
"
Class {
	#name : #OPUmlModelSerializerTest,
	#superclass : #TestCase,
	#category : #'OpenPonk-ClassEditor-Tests'
}

{ #category : #accessing }
OPUmlModelSerializerTest >> mementoSerializerClass [
	^ OPUmlModelSerializer
]

{ #category : #'instance creation' }
OPUmlModelSerializerTest >> newModel [
	^ OPUmlExamples new simpleAssociation
]

{ #category : #tests }
OPUmlModelSerializerTest >> testRoundtrip [
	| originalModel loadedModel serialization |
	originalModel := self newModel.
	serialization := serializer serializeModel: originalModel.
	loadedModel := serializer materializeModelFrom: serialization.
	self
		assert: (originalModel packagedElements collect: #name)
		equals: (loadedModel packagedElements collect: #name)
]
