"
An OPUmlSerializerTest is a test class for testing the behavior of OPUmlSerializer
"
Class {
	#name : #OPUmlSerializerTest,
	#superclass : #OPAbstractSerializerTest,
	#category : #'OpenPonk-ClassEditor-Tests'
}

{ #category : #accessing }
OPUmlSerializerTest >> modelSerializerClass [
	^ OPUmlModelSerializer
]

{ #category : #'instance creation' }
OPUmlSerializerTest >> newModel [
	^ OPUmlExamples new simpleAssociation
]

{ #category : #tests }
OPUmlSerializerTest >> testRoundtrip [
	| originalModel loadedModel serialization |
	originalModel := self newModel.
	serialization := serializer serializeModel: originalModel.
	loadedModel := serializer materializeModelFrom: serialization.
	self
		assert: (originalModel packagedElements collect: #name)
		equals: (loadedModel packagedElements collect: #name)
]
