"
Unit tests verifying the Spec 2 UML profile generator wizard inputs, validation, window setup, and generated changes.
"
Class {
	#name : 'OPUmlProfileGeneratorWizardTest',
	#superclass : 'TestCase',
	#instVars : [
		'preexistingWindows'
	],
	#category : 'OpenPonk-ClassEditor-Tests-UI',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'UI'
}

{ #category : 'running' }
OPUmlProfileGeneratorWizardTest >> setUp [

	super setUp.
	preexistingWindows := (self currentWorld submorphs select: [ :each | each isSystemWindow ]) asIdentitySet
]

{ #category : 'running' }
OPUmlProfileGeneratorWizardTest >> tearDown [

	| existing |
	existing := preexistingWindows ifNil: [ IdentitySet new ].
	self currentWorld submorphs copy do: [ :each |
		(each isSystemWindow and: [ (existing includes: each) not ]) ifTrue: [ each delete ] ].
	super tearDown
]

{ #category : 'tests' }
OPUmlProfileGeneratorWizardTest >> testDefaultInputsForFreshProfile [

	| profile wizard |
	profile := OPUMLProfile new
		           name: 'Sample';
		           yourself.
	wizard := OPUmlProfileGeneratorWizard on: profile.
	self assert: wizard prefixInput text equals: 'Sample'.
	self assert: wizard packageInput text equals: 'Sample-Profile'.
	self
		assert: wizard generateButton isEnabled
		description: 'Generate button must be enabled when both prefix and package are non-empty'
]

{ #category : 'tests' }
OPUmlProfileGeneratorWizardTest >> testDefaultInputsPreserveConfiguredProfileMetadata [

	| profile wizard |
	profile := OPUMLProfile new
		           name: 'Sample';
		           implementationPrefix: 'Smp';
		           implementationPackage: 'Custom-Sample-Profile';
		           yourself.
	wizard := OPUmlProfileGeneratorWizard on: profile.
	self assert: wizard prefixInput text equals: 'Smp'.
	self assert: wizard packageInput text equals: 'Custom-Sample-Profile'
]

{ #category : 'tests' }
OPUmlProfileGeneratorWizardTest >> testGenerateButtonClickOpensChangesBrowserAndClosesWizardWindow [

	| profile stereotypePair wizard wizardWindow |
	profile := OPUMLProfile new
		           name: 'Sample';
		           yourself.
	stereotypePair := OPUmlCustomProfile new newStereotype: 'MyTag' to: (OPUMLXMISpecsStorage metaClassNamed: 'Class').
	profile packagedElements addAll: stereotypePair.
	wizard := OPUmlProfileGeneratorWizard on: profile.
	wizard prefixInput text: 'Smp'.
	wizard packageInput text: 'Sample-Generated'.
	wizardWindow := wizard open.
	[
		wizard generateButton click.
		self deny: wizardWindow isOpen description: 'Clicking Generate button must close the wizard window'.
		self
			assert: ((self currentWorld submorphs reject: [ :each | preexistingWindows includes: each ]) anySatisfy: [ :each |
					 each isSystemWindow and: [ each model presenter class == CBChangesBrowser ] ])
			description: 'Clicking Generate button must open a CBChangesBrowser window' ] ensure: [
		wizardWindow isOpen ifTrue: [ wizardWindow close ] ]
]

{ #category : 'tests' }
OPUmlProfileGeneratorWizardTest >> testGenerateButtonDisabledWhenPrefixOrPackageEmpty [

	| profile wizard |
	profile := OPUMLProfile new
		           name: 'Sample';
		           yourself.
	wizard := OPUmlProfileGeneratorWizard on: profile.
	wizard prefixInput text: ''.
	self deny: wizard generateButton isEnabled description: 'Generate button must be disabled when class prefix is empty'.
	wizard prefixInput text: 'Smp'.
	wizard packageInput text: ''.
	self deny: wizard generateButton isEnabled description: 'Generate button must be disabled when target package is empty'.
	wizard packageInput text: 'Sample-Profile'.
	self assert: wizard generateButton isEnabled description: 'Generate button must be enabled once both inputs are non-empty'
]

{ #category : 'tests' }
OPUmlProfileGeneratorWizardTest >> testGenerateChangesRejectsEmptyPrefixOrPackage [

	| profile wizard |
	profile := OPUMLProfile new
		           name: 'Sample';
		           yourself.
	wizard := OPUmlProfileGeneratorWizard on: profile.
	wizard prefixInput text: ''.
	self should: [ wizard generateChanges ] raise: AssertionFailure description: 'generateChanges must reject an empty class prefix'
]

{ #category : 'tests' }
OPUmlProfileGeneratorWizardTest >> testGenerateChangesUpdatesProfileMetadataAndGeneratesPackageAndExtensions [

	| profile stereotypePair wizard changes extensionChanges classChange |
	profile := OPUMLProfile new
		           name: 'Sample';
		           yourself.
	stereotypePair := OPUmlCustomProfile new newStereotype: 'MyTag' to: (OPUMLXMISpecsStorage metaClassNamed: 'Class').
	profile packagedElements addAll: stereotypePair.
	wizard := OPUmlProfileGeneratorWizard on: profile.
	wizard prefixInput text: 'Smp'.
	wizard packageInput text: 'Sample-Generated'.
	changes := wizard generateChanges.
	self assert: profile implementationPrefix equals: 'Smp'.
	self assert: profile implementationPackage equals: 'Sample-Generated'.
	self denyEmpty: changes.
	extensionChanges := changes select: [ :each | each changeClassName = #OPUMLClass and: [ each isKindOf: ReAddMethodChange ] ].
	self assertCollection: (extensionChanges collect: #selector) hasSameElements: #( #extension_MyTag #extension_MyTag: ).
	extensionChanges do: [ :each | self assert: each protocol equals: #'*Sample-Generated' ].
	classChange := changes detect: [ :each | each changeClassName = #SmpMyTag and: [ each isKindOf: ReAddClassChange ] ].
	self assert: classChange package equals: #'Sample-Generated'.
	self assert: classChange tag equals: #Model
]

{ #category : 'tests' }
OPUmlProfileGeneratorWizardTest >> testGenerateOpensChangesBrowserAndClosesWizardWindow [

	| profile stereotypePair wizard wizardWindow changesBrowser |
	profile := OPUMLProfile new
		           name: 'Sample';
		           yourself.
	stereotypePair := OPUmlCustomProfile new newStereotype: 'MyTag' to: (OPUMLXMISpecsStorage metaClassNamed: 'Class').
	profile packagedElements addAll: stereotypePair.
	wizard := OPUmlProfileGeneratorWizard on: profile.
	wizard prefixInput text: 'Smp'.
	wizard packageInput text: 'Sample-Generated'.
	wizardWindow := wizard open.
	[
		changesBrowser := wizard generate.
		[
			self assert: changesBrowser class identicalTo: CBChangesBrowser.
			self assert: changesBrowser window class identicalTo: SpDialogWindowPresenter.
			self assert: changesBrowser window isOpen description: 'Changes browser dialog must be open'.
			self deny: wizardWindow isOpen description: 'Wizard window must close after opening CBChangesBrowser' ] ensure: [
			changesBrowser ifNotNil: [ changesBrowser withWindowDo: [ :window | window close ] ] ] ] ensure: [
		wizardWindow isOpen ifTrue: [ wizardWindow close ] ]
]

{ #category : 'tests' }
OPUmlProfileGeneratorWizardTest >> testProfileSetterAndUnnamedProfileDefaults [

	| wizard unnamedProfile |
	unnamedProfile := OPUMLProfile new.
	wizard := OPUmlProfileGeneratorWizard new.
	wizard profile: unnamedProfile.
	self assert: wizard profile identicalTo: unnamedProfile.
	self assertEmpty: wizard prefixInput text.
	self assertEmpty: wizard packageInput text.
	self
		deny: wizard generateButton isEnabled
		description: 'Generate button must be disabled for an unnamed profile without prefix or package'
]

{ #category : 'tests' }
OPUmlProfileGeneratorWizardTest >> testWindowOpensWithExpectedTitleAndBounds [

	| profile wizard window |
	profile := OPUMLProfile new
		           name: 'Sample';
		           yourself.
	wizard := OPUmlProfileGeneratorWizard on: profile.
	window := wizard open.
	[
		self assert: window title equals: 'Generate code for profile Sample'.
		self assert: window initialExtent equals: 420 @ 140 ] ensure: [ window close ]
]
