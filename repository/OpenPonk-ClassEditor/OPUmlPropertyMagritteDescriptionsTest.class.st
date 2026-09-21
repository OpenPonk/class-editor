"
I am a unit test class verifying the accurate generation of Magritte form descriptions for configuring UML Properties.
"
Class {
	#name : 'OPUmlPropertyMagritteDescriptionsTest',
	#superclass : 'TestCase',
	#instVars : [
		'project',
		'package',
		'classA',
		'classB',
		'association',
		'firstEnd',
		'secondEnd',
		'viewModel',
		'descriptions'
	],
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'as yet unclassified' }
OPUmlPropertyMagritteDescriptionsTest >> setUp [
	| registry |
	super setUp.
	project := OPProject new.
	package := OPUMLPackage new name: 'TestPackage'.
	project addModel: package.

	classA := OPUMLClass new name: 'ClassA'.
	classB := OPUMLClass new name: 'ClassB'.
	package packagedElements add: classA; add: classB.

	association := OPUMLAssociation new name: 'A_B'.
	firstEnd := OPUMLProperty new name: 'endA'; type: classA; owningAssociation: association.
	secondEnd := OPUMLProperty new name: 'endB'; type: classB; owningAssociation: association.
	firstEnd association: association.
	secondEnd association: association.
	association memberEnds add: firstEnd; add: secondEnd.
	package packagedElements add: association.

	registry := OPViewModelRegistry forProject: project.
	viewModel := registry viewModelFor: association.
	descriptions := OPUmlPropertyMagritteDescriptions
		reader: [ :vm | vm model memberEnds second ]
		labelPrefix: 'Target '.
]

{ #category : 'as yet unclassified' }
OPUmlPropertyMagritteDescriptionsTest >> tearDown [
	descriptions := nil.
	viewModel := nil.
	firstEnd := nil.
	secondEnd := nil.
	association := nil.
	classA := nil.
	classB := nil.
	package := nil.
	project := nil.
	super tearDown
]

{ #category : 'tests' }
OPUmlPropertyMagritteDescriptionsTest >> testDescriptionAccessor [
	| property reader desc |
	property := OPUMLProperty new.
	reader := [ :nope | property ].
	desc := OPUmlPropertyMagritteDescriptions reader: reader labelPrefix: ''.
	(desc descriptionAccessor: #name) write: 'hello' to: nil.
	self assert: ((desc descriptionAccessor: #name) read: nil) equals: 'hello'
]

{ #category : 'as yet unclassified' }
OPUmlPropertyMagritteDescriptionsTest >> testWriteMultiplicityAndDefaultValue [
	| multDesc defDesc |
	multDesc := descriptions descriptionMultiplicity.
	multDesc accessor write: '0..*' to: viewModel.
	self assert: secondEnd lowerBound value equals: 0.
	self assert: secondEnd upperBound value equals: '*'.

	defDesc := descriptions descriptionDefaultValue.
	defDesc accessor write: 'initVal' to: viewModel.
	self assert: (defDesc accessor read: viewModel) equals: 'initVal'
]

{ #category : 'as yet unclassified' }
OPUmlPropertyMagritteDescriptionsTest >> testWriteNavigabilityUpdatesModelWithoutDnu [
	| description accessor |
	description := descriptions descriptionIsNavigable.
	accessor := description accessor.

	self deny: (accessor read: viewModel).
	self deny: secondEnd isNavigable.

	accessor write: true to: viewModel.

	self assert: (accessor read: viewModel).
	self assert: secondEnd isNavigable.
	self assert: secondEnd owningClass equals: classA.

	accessor write: false to: viewModel.

	self deny: (accessor read: viewModel).
	self deny: secondEnd isNavigable.
	self assert: secondEnd owningAssociation equals: association
]
