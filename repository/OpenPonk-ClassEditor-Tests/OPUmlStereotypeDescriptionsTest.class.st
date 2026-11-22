"
Verifies Magritte description generation and property accessors for stereotypes applied to UML elements.
"
Class {
	#name : 'OPUmlStereotypeDescriptionsTest',
	#superclass : 'TestCase',
	#instVars : [
		'project',
		'package',
		'umlClass',
		'viewModel'
	],
	#category : 'OpenPonk-ClassEditor-Tests-Profiles',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Profiles'
}

{ #category : 'running' }
OPUmlStereotypeDescriptionsTest >> setUp [

	| registry |
	super setUp.
	project := OPProject named: 'StereotypeTest'.
	package := OPUMLPackage new name: 'RootPackage'.
	umlClass := OPUMLClass new name: 'Server'.
	package packagedElements add: umlClass.
	project addModel: package.
	registry := OPViewModelRegistry forProject: project.
	viewModel := registry viewModelFor: umlClass
]

{ #category : 'running' }
OPUmlStereotypeDescriptionsTest >> tearDown [

	viewModel := nil.
	umlClass := nil.
	package := nil.
	project := nil.
	super tearDown
]

{ #category : 'tests' }
OPUmlStereotypeDescriptionsTest >> testAccessorReadsWritesAndAnnouncesModelChanged [

	| clockStereotype generatedDescriptions osVersionDescription posixDescription changeCount |
	clockStereotype := ClClock new.
	umlClass applyStereotype: clockStereotype.
	changeCount := 0.
	viewModel announcer when: OPModelChanged do: [ changeCount := changeCount + 1 ] for: self.

	generatedDescriptions := (OPUmlStereotypeDescriptions for: viewModel) descriptions.
	osVersionDescription := generatedDescriptions detect: [ :each | each label = 'Os Version' ].
	posixDescription := generatedDescriptions detect: [ :each | each label = 'Is Posix Compliant' ].

	osVersionDescription accessor write: 'Linux 6.x' to: viewModel.
	self assert: clockStereotype osVersion equals: 'Linux 6.x'.
	self assert: (osVersionDescription accessor read: viewModel) equals: 'Linux 6.x'.

	posixDescription accessor write: true to: viewModel.
	self assert: clockStereotype posixCompliant description: 'Clock posixCompliant must be true after write'.
	self assert: (posixDescription accessor read: viewModel) description: 'Accessor must read true after write'.
	self assert: changeCount equals: 2
]

{ #category : 'tests' }
OPUmlStereotypeDescriptionsTest >> testAddToAttributeWithNilTypeIsIgnored [

	| stereotypeDescriptions collectedDescriptions untypedAttribute |
	stereotypeDescriptions := OPUmlStereotypeDescriptions for: viewModel.
	collectedDescriptions := OrderedCollection new.
	untypedAttribute := OPUMLProperty new name: 'untyped'.

	stereotypeDescriptions addTo: collectedDescriptions attribute: untypedAttribute of: ClClock new.

	self assertEmpty: collectedDescriptions
]

{ #category : 'tests' }
OPUmlStereotypeDescriptionsTest >> testDescriptionsForClockStereotypeIncludesStringAndBooleanAndSkipsClassAttribute [

	| clockStereotype generatedDescriptions osVersionDescription posixDescription |
	clockStereotype := ClClock new.
	umlClass applyStereotype: clockStereotype.

	generatedDescriptions := (OPUmlStereotypeDescriptions for: viewModel) descriptions.

	self assertCollection: (generatedDescriptions collect: #label) hasSameElements: #( 'Os Version' 'Is Posix Compliant' ).
	osVersionDescription := generatedDescriptions detect: [ :each | each label = 'Os Version' ].
	posixDescription := generatedDescriptions detect: [ :each | each label = 'Is Posix Compliant' ].
	self assert: osVersionDescription class identicalTo: MAStringDescription.
	self assert: posixDescription class identicalTo: MABooleanDescription
]

{ #category : 'tests' }
OPUmlStereotypeDescriptionsTest >> testDescriptionsWhenModelIsNilReturnsEmpty [

	| emptyDescriptions viewModelWithoutModel |
	emptyDescriptions := OPUmlStereotypeDescriptions new.
	self assert: emptyDescriptions model equals: nil.
	self assertEmpty: emptyDescriptions descriptions.

	viewModelWithoutModel := OPUmlClassViewModel new.
	self assertEmpty: (OPUmlStereotypeDescriptions for: viewModelWithoutModel) descriptions
]

{ #category : 'tests' }
OPUmlStereotypeDescriptionsTest >> testDescriptionsWhenNoAppliedStereotypesReturnsEmpty [

	self assertEmpty: (OPUmlStereotypeDescriptions for: viewModel) descriptions
]

{ #category : 'tests' }
OPUmlStereotypeDescriptionsTest >> testForSetsViewModelAndModel [

	| stereotypeDescriptions |
	stereotypeDescriptions := OPUmlStereotypeDescriptions for: viewModel.

	self assert: stereotypeDescriptions viewModel identicalTo: viewModel.
	self assert: stereotypeDescriptions model identicalTo: umlClass
]
