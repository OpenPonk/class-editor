"
An OPUmlSerializerTest is a test class for testing the behavior of OPUmlSerializer
"
Class {
	#name : #OPUmlModelSerializerTest,
	#superclass : #OPModelSerializerTest,
	#category : #'OpenPonk-ClassEditor-Tests'
}

{ #category : #'instance creation' }
OPUmlModelSerializerTest >> newModel [
	^ OPUmlExamples new simpleAssociation
]

{ #category : #accessing }
OPUmlModelSerializerTest >> serializerClass [
	^ OPUmlModelSerializer
]

{ #category : #tests }
OPUmlModelSerializerTest >> testRoundtrip [
	| newModel |
	serializer serializeModel: model to: stream.
	newModel := serializer materializeModelFrom: stream.
	self deny: newModel identicalTo: model.
	self
		assert: (newModel packagedElements collect: #name)
		equals: (model packagedElements collect: #name)
]
