"
I am a unit test class verifying the accurate generation of Magritte form descriptions for configuring UML Properties.
"
Class {
	#name : 'OPUmlPropertyMagritteDescriptionsTest',
	#superclass : 'TestCase',
	#instVars : [
		'property',
		'desc',
		'reader'
	],
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'tests' }
OPUmlPropertyMagritteDescriptionsTest >> testDescriptionAccessor [
	property := OPUMLProperty new.
	reader := [ :nope | property ].
	desc := OPUmlPropertyMagritteDescriptions reader: reader labelPrefix: ''.
	(desc descriptionAccessor: #name) write: 'hello' to: nil.
	self assert: ((desc descriptionAccessor: #name) read: nil) equals: 'hello'
]
