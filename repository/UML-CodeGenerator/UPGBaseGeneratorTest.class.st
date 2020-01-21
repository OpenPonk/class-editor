Class {
	#name : #UPGBaseGeneratorTest,
	#superclass : #TestCase,
	#instVars : [
		'factory',
		'model',
		'cls',
		'generator'
	],
	#category : 'UML-CodeGenerator-Tests'
}

{ #category : #testing }
UPGBaseGeneratorTest class >> isAbstract [
	^ self = UPGBaseGeneratorTest
]

{ #category : #asserting }
UPGBaseGeneratorTest >> ast: expected equals: actual [
	self assert: (self astFor: expected) equals: (self astFor: actual)
]

{ #category : #utilities }
UPGBaseGeneratorTest >> astFor: aMethodExpression [
	aMethodExpression isString
		ifTrue: [ ^ RBParser parseMethod: aMethodExpression ].
	aMethodExpression isCompiledMethod
		ifTrue: [ aMethodExpression ast ].
	^ aMethodExpression
]

{ #category : #accessing }
UPGBaseGeneratorTest >> categoryName [
	^ 'OpenPonk-GeneratorTest'
]

{ #category : #'instance creation' }
UPGBaseGeneratorTest >> newClassNamed: aName [
	^ self newClassNamed: aName inCategory: self categoryName
]

{ #category : #'instance creation' }
UPGBaseGeneratorTest >> newClassNamed: aName inCategory: aCategory [
	| klass |
	klass := Object
		subclass: aName
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: aCategory.
	^ klass
]

{ #category : #running }
UPGBaseGeneratorTest >> setUp [
	super setUp.
	factory := OPUmlDSLFactory new.
	self suspendedDo: [ RPackage organizer registerPackageNamed: self categoryName ]
]

{ #category : #running }
UPGBaseGeneratorTest >> suspendedDo: aBlock [
	SystemAnnouncer uniqueInstance suspendAllWhile: aBlock
]

{ #category : #running }
UPGBaseGeneratorTest >> tearDown [
	super tearDown.
	self
		suspendedDo:
			[ (RPackage organizer packageNamed: 'OpenPonk-GeneratorTest') classes
				do: [ :each | each removeFromSystemUnlogged ] ]
]
