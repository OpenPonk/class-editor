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
OPUmlModelSerializerTest >> testNoNames [

	serializer serializeModel: model to: stream.
	model name: nil.
	self
		should: [ serializer serializeModel: model to: stream ]
		raise: AssertionFailure
		description:
		'Serialization should fail because model must have a name'.
	model name: ''.
	self
		should: [ serializer serializeModel: model to: stream ]
		raise: AssertionFailure
		description:
		'Serialization should fail because model must have a name'.
	model name: 'Test'.
	serializer serializeModel: model to: stream.
	model packagedElements first name: nil.
	self
		should: [ serializer serializeModel: model to: stream ]
		raise: AssertionFailure
		description:
		'Serialization should fail because classes must have a name'.
	model packagedElements first name: ''.
	self
		should: [ serializer serializeModel: model to: stream ]
		raise: AssertionFailure
		description:
		'Serialization should fail because model must have a name'
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
