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
	#category : 'OpenPonk-ClassEditor-Tests-Forms',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Forms'
}

{ #category : 'running' }
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

{ #category : 'running' }
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

	| property reader propertyDescriptions nameAccessor changeCount |
	property := OPUMLProperty new.
	reader := [ :ignored | property ].
	propertyDescriptions := OPUmlPropertyMagritteDescriptions reader: reader labelPrefix: ''.
	(propertyDescriptions descriptionAccessor: #name) write: 'hello' to: nil.
	self assert: ((propertyDescriptions descriptionAccessor: #name) read: nil) equals: 'hello'.

	changeCount := 0.
	viewModel announcer when: OPModelChanged do: [ changeCount := changeCount + 1 ] for: self.
	nameAccessor := descriptions descriptionAccessor: #name.
	nameAccessor write: 'renamedEnd' to: viewModel.

	self assert: (nameAccessor read: viewModel) equals: 'renamedEnd'.
	self assert: secondEnd name equals: 'renamedEnd'.
	self assert: changeCount equals: 1
]

{ #category : 'tests' }
OPUmlPropertyMagritteDescriptionsTest >> testDescriptionDefaultValueClearAndNilWrite [

	| defaultValueDescription accessor |
	defaultValueDescription := descriptions descriptionDefaultValue.
	accessor := defaultValueDescription accessor.

	accessor write: 'initial' to: viewModel.
	self assert: (accessor read: viewModel) equals: 'initial'.

	accessor write: '' to: viewModel.
	self assert: (accessor read: viewModel) equals: ''.

	accessor write: nil to: viewModel.
	self assert: (accessor read: viewModel) equals: ''
]

{ #category : 'tests' }
OPUmlPropertyMagritteDescriptionsTest >> testDescriptionDefaultValueEdgeCases [

	| defaultValueDescription accessor literalDefaultValue |
	defaultValueDescription := descriptions descriptionDefaultValue.
	accessor := defaultValueDescription accessor.

	self assert: (accessor read: viewModel) equals: ''.

	literalDefaultValue := OPUMLLiteralString new value: 'literal'.
	secondEnd defaultValue: literalDefaultValue.
	self assert: (accessor read: viewModel) equals: ''.

	accessor write: 'ignoredForLiteral' to: viewModel.
	self assert: secondEnd defaultValue identicalTo: literalDefaultValue
]

{ #category : 'tests' }
OPUmlPropertyMagritteDescriptionsTest >> testDescriptionType [

	| typeDescription accessor |
	typeDescription := descriptions descriptionType.
	accessor := typeDescription accessor.

	self assert: typeDescription isReadOnly description: 'Association end type description must be read-only'.
	self assert: (accessor read: viewModel) equals: 'ClassB'.

	accessor write: 'OtherClass' to: viewModel.
	self assert: secondEnd type identicalTo: classB.

	secondEnd type: nil.
	self assert: (accessor read: viewModel) equals: ''
]

{ #category : 'tests' }
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

{ #category : 'tests' }
OPUmlPropertyMagritteDescriptionsTest >> testWriteNavigabilityUpdatesModelWithoutDnu [

	| description accessor |
	description := descriptions descriptionIsNavigable.
	accessor := description accessor.

	self deny: (accessor read: viewModel) description: 'Target end must initially not be navigable'.
	self deny: secondEnd isNavigable description: 'Target property must initially not be navigable'.

	accessor write: true to: viewModel.

	self assert: (accessor read: viewModel) description: 'Accessor must read true after enabling navigability'.
	self assert: secondEnd isNavigable description: 'Target property must become navigable after write: true'.
	self assert: secondEnd owningClass identicalTo: classA.

	accessor write: false to: viewModel.

	self deny: (accessor read: viewModel) description: 'Accessor must read false after disabling navigability'.
	self deny: secondEnd isNavigable description: 'Target property must become non-navigable after write: false'.
	self assert: secondEnd owningAssociation identicalTo: association
]
