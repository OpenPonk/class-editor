Class {
	#name : #UPGSimpleAccessorsGenerator,
	#superclass : #UPGBaseAssociationGenerator,
	#category : 'UML-CodeGenerator-Generators'
}

{ #category : #'generator - templates' }
UPGSimpleAccessorsGenerator >> adder: anEnd [
	^ self
		replace: (self templateNamed: #adder:)
		with:
			{#adder: -> ('add' , anEnd name asEnglishSingular capitalized , ':').
			#aValue -> (self typeNameForEnd: anEnd).
			#container -> anEnd name}
]

{ #category : #'generator - templates' }
UPGSimpleAccessorsGenerator >> eagerGetter: anEnd [
	^ self
		replace: (self templateNamed: #getter)
		with:
			{#getter -> anEnd name.
			#_dsl_ -> (self dslFor: anEnd association)}
]

{ #category : #'generator - templates' }
UPGSimpleAccessorsGenerator >> getter: anEnd [
	self context shouldUseEagerInitialization
		ifTrue: [ ^ self eagerGetter: anEnd ].
	self context shouldUseLazyInitialization
		ifTrue: [ ^ self lazyGetter: anEnd ]
]

{ #category : #'generator - templates' }
UPGSimpleAccessorsGenerator >> lazyGetter: anEnd [
	^ self
		replace: (self templateNamed: #lazyGetter)
		with:
			{#lazyGetter -> anEnd name.
			#getter -> anEnd name.
			#_dsl_ -> (self dslFor: anEnd association)}
]

{ #category : #'generator - templates' }
UPGSimpleAccessorsGenerator >> remover: anEnd [
	^ self
		replace: (self templateNamed: #remover:)
		with:
			{#remover: -> ('remove' , anEnd name asEnglishSingular capitalized , ':').
			#aValue -> (self typeNameForEnd: anEnd).
			#container -> anEnd name}
]

{ #category : #utilities }
UPGSimpleAccessorsGenerator >> replace: aString with: anArray [
	| newString |
	newString := aString.
	anArray do: [ :each | newString := newString copyReplaceAll: each key with: each value ].
	^ newString
]

{ #category : #'generator - templates' }
UPGSimpleAccessorsGenerator >> setter: anEnd [
	^ self
		replace: (self templateNamed: #setter:)
		with:
			{#aValue -> (self paramNameForEnd: anEnd).
			#setter -> anEnd name}
]

{ #category : #utilities }
UPGSimpleAccessorsGenerator >> templateNamed: aSymbol [
	^ (UPGSimpleAccessorsTemplates >> aSymbol) sourceCode
]
