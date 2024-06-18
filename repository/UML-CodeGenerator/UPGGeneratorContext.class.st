"
I provide context and configuration options for the code generator.
"
Class {
	#name : 'UPGGeneratorContext',
	#superclass : 'Object',
	#instVars : [
		'showProgressBar',
		'overrideMethods',
		'generateAccessors',
		'prefix',
		'useLazyLoading',
		'useEagerLoading',
		'package',
		'conflictPrefix',
		'alwaysUsePrefix',
		'accessorsStyle'
	],
	#category : 'UML-CodeGenerator-Generators',
	#package : 'UML-CodeGenerator',
	#tag : 'Generators'
}

{ #category : 'accessing-readonly' }
UPGGeneratorContext >> accessorsStyle [
	^ accessorsStyle
]

{ #category : 'options' }
UPGGeneratorContext >> accessorsStyle: aStyle [
	self assert: [ #(simple direct fame) includes: aStyle ].
	accessorsStyle := aStyle
]

{ #category : 'options' }
UPGGeneratorContext >> alwaysUsePrefix [
	alwaysUsePrefix := true
]

{ #category : 'initialization' }
UPGGeneratorContext >> defaultOptions [
	self package: #Unclassified.
	self prefix: ''.
	alwaysUsePrefix := false.
	self accessorsStyle: #simple.
	self withProgressBar.
	self withAccessors.
	self doNotOverrideMethods.
	self useLazyInitialization
]

{ #category : 'options' }
UPGGeneratorContext >> doNotOverrideMethods [
	overrideMethods := false
]

{ #category : 'initialization' }
UPGGeneratorContext >> initialize [
	super initialize.
	self defaultOptions
]

{ #category : 'options' }
UPGGeneratorContext >> overrideMethods [
	"Should existing methods be overriden?"

	overrideMethods := true
]

{ #category : 'accessing-readonly' }
UPGGeneratorContext >> package [
	^ package
]

{ #category : 'options' }
UPGGeneratorContext >> package: aString [
	"Name of the package/category where the classes should be placed"

	package := aString
]

{ #category : 'accessing-readonly' }
UPGGeneratorContext >> prefix [
	^ prefix
]

{ #category : 'options' }
UPGGeneratorContext >> prefix: aString [
	"Prefix all generated classes with aString"

	prefix := aString
]

{ #category : 'accessing-readonly' }
UPGGeneratorContext >> shouldAddAccessors [
	^ generateAccessors
]

{ #category : 'accessing-readonly' }
UPGGeneratorContext >> shouldAlwaysUsePrefix [
	^ alwaysUsePrefix
]

{ #category : 'accessing-readonly' }
UPGGeneratorContext >> shouldOverrideMethods [
	^ overrideMethods
]

{ #category : 'accessing-readonly' }
UPGGeneratorContext >> shouldShowProgressBar [
	^ showProgressBar
]

{ #category : 'accessing-readonly' }
UPGGeneratorContext >> shouldUseEagerInitialization [
	^ useEagerLoading
]

{ #category : 'accessing-readonly' }
UPGGeneratorContext >> shouldUseLazyInitialization [
	^ useLazyLoading
]

{ #category : 'options' }
UPGGeneratorContext >> useEagerInitialization [
	useLazyLoading := false.
	useEagerLoading := true
]

{ #category : 'options' }
UPGGeneratorContext >> useLazyInitialization [
	"Add default value of attributes to getters.
	This setting will generate a getter even if the context is #withoutAccessors. (But will not generate a setter)"

	useLazyLoading := true.
	useEagerLoading := false
]

{ #category : 'options' }
UPGGeneratorContext >> withAccessors [
	"Generate accessors (setter, getter, add/remove) for instance variables"

	generateAccessors := true
]

{ #category : 'options' }
UPGGeneratorContext >> withProgressBar [
	"Show progress bar depicting the progress of the code generation."

	showProgressBar := true
]

{ #category : 'options' }
UPGGeneratorContext >> withoutAccessors [
	"Generate accessors (setter, getter, add/remove) for instance variables"

	generateAccessors := false
]

{ #category : 'options' }
UPGGeneratorContext >> withoutProgressBar [
	showProgressBar := false
]
