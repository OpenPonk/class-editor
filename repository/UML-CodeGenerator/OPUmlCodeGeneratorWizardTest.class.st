Class {
	#name : 'OPUmlCodeGeneratorWizardTest',
	#superclass : 'TestCase',
	#category : 'UML-CodeGenerator-Windows',
	#package : 'UML-CodeGenerator',
	#tag : 'Windows'
}

{ #category : 'tests' }
OPUmlCodeGeneratorWizardTest >> testCreateContext [
	| dict context |
	dict := {#package -> 'Target'.
	#alwaysUsePrefix -> true.
	#addAccessors -> true.
	#overrideMethods -> true.
	#classPrefix -> 'Cls'.
	#initializationType -> #lazy.
	#accessorsStyle -> #fame} asDictionary.
	context := OPUmlCodeGeneratorWizard new createContextFrom: dict.
	self assert: context package equals: 'Target'.
	self assert: context shouldAddAccessors.
	self assert: context shouldOverrideMethods.
	self assert: context prefix equals: 'Cls'.
	self assert: context shouldAlwaysUsePrefix.
	self assert: context shouldUseLazyInitialization.
	self assert: context accessorsStyle equals: #fame.
	self deny: context shouldUseEagerInitialization
]
